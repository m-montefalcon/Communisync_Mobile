import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../../../main.dart';

Future<void> loginUser(context, String email, String password) async {
  try {
    String host = dotenv.get("API_HOST", fallback: "");
    String loginApi = dotenv.get("LOGIN_API", fallback: "");
    final url = ('$host$loginApi');
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_name': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String token = responseData['token'];
      Map<String, dynamic> user = responseData['user'] as Map<String, dynamic>;
      String role = user['role'];
      int id = user['id'];
      // String fcmToken = responseData['fcm_token']; // Get the FCM token


      if (token != null && role != null) {




        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setInt('id', id);




        if (role == '1') {
          await initializeFirebase();
          FirebaseMessaging.instance.subscribeToTopic('role_$role');
          FirebaseMessaging.instance.subscribeToTopic('id_$id');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VisitorBottombar()),
                (route) => false,
          );
        } else if (role == '2') {
          await initializeFirebase();

          Navigator.pushAndRemoveUntil(

            context,
            MaterialPageRoute(builder: (context) => const HomeownerBottomNavigationBar()),
                (route) => false,
          );
        } else {
          await initializeFirebase();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SecurityPersonnelBottomBar()),
                (route) => false,
          );
        }
      } else {
        throw Exception('Invalid API response');
      }
    } else {
      throw ('Invalid Credentials');
    }
  } catch (e) {
    throw (e);
  }
}
Future<void> initializeFirebase() async {
  // Load environment variables from the dotenv file
  await dotenv.load(fileName: "dotenv");
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize Firebase messaging foreground handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Show notification using awesome_notifications
      showAwesomeNotification(message.notification?.title, message.notification?.body);

      // Show overlay after the notification
      showOverlayNotification((context) {
        return CustomOverlay(
          title: message.notification?.title,
          body: message.notification?.body,
        );
      }, key: Key('overlay'),
          duration: Duration(seconds: 7)
      );
    });

    // Also handle when the app is in the foreground but opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        showAwesomeNotification(message.notification?.title, message.notification?.body);

        // Show overlay after the notification
        showOverlayNotification((context) {
          return CustomOverlay(
            title: message.notification?.title,
            body: message.notification?.body,
          );
        }, key: Key('overlay'),
            duration: Duration(seconds: 7));
      }
    });

  } catch (e) {
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase push notification
  showAwesomeNotification(message.notification?.title, message.notification?.body);

}