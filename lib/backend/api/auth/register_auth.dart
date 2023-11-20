import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:communisyncmobile/firebase_options.dart';
import 'package:communisyncmobile/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../screens/login_page.dart';

Future<void> registerUser(
    context,
    String userName,
    String firstName,
    String lastName,
    String contactNumber,
    String email,
    String password,
    String photoPath,
    ) async {
  try {
    await initializeFirebase();
    // Get the FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    String host = dotenv.get("API_HOST", fallback: "");
    String registerApi = dotenv.get("REGISTER_API", fallback: "");
    final url = ('$host$registerApi');
    print("URL: $url");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Accept'] = 'application/json';

    // Add fields as parts
    request.fields['user_name'] = userName;
    request.fields['email'] = email;
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['contact_number'] = contactNumber;
    request.fields['password'] = password;
    request.fields['fcm_token'] = fcmToken!; // Add FCM token

    // Add photo as a part
    // Read the photo file as bytes
    File photoFile = File(photoPath);
    List<int> photoBytes = await photoFile.readAsBytes();

    // Add the photo file as a part
    request.files.add(http.MultipartFile.fromBytes(
      'photo',
      photoBytes,
      filename: 'photo.jpg',
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Registration successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    } else {
      final responseBody = await response.stream.bytesToString();
      final errorMessage = jsonDecode(responseBody)['message'];
      throw errorMessage;
    }
  } catch (e) {
    print("Exception caught in registerUser: $e");
    throw (e);
  }
}



Future<void> initializeFirebase() async {
  // Load environment variables from the dotenv file
  await dotenv.load(fileName: "dotenv");
  print("Before Firebase.initializeApp()");
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        )
      ],
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize Firebase messaging foreground handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Handling a foreground message: ${message.messageId}");
      // Show notification using awesome_notifications
      showAwesomeNotification(message.notification?.title, message.notification?.body);

      // Show overlay after the notification
      showOverlayNotification((context) {
        return CustomOverlay(
          title: message.notification?.title,
          body: message.notification?.body,
        );
      }, key: Key('overlay'));
    });

    // Also handle when the app is in the foreground but opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("Handling initial message: ${message.messageId}");
        showAwesomeNotification(message.notification?.title, message.notification?.body);

        // Show overlay after the notification
        showOverlayNotification((context) {
          return CustomOverlay(
            title: message.notification?.title,
            body: message.notification?.body,
          );
        }, key: Key('overlay'));
      }
    });

    print("Firebase.initializeApp() succeeded");
  } catch (e) {
    print("Firebase.initializeApp() failed: $e");
  }
  print("After Firebase.initializeApp()");
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}
