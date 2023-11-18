import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';
import '../main.dart';
import 'login_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override

  String role = '';
  Future<Widget> _getRolePage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role') ?? '';
    int id = prefs.getInt('id') ?? 0;

    if (role == '1') {

      await initializeFirebase();
      FirebaseMessaging.instance.subscribeToTopic('role_$role');
      FirebaseMessaging.instance.subscribeToTopic('id_$id');

      return const VisitorBottombar();
    } else if (role == '2') {

      await initializeFirebase();
      FirebaseMessaging.instance.subscribeToTopic('role_$role');
      FirebaseMessaging.instance.subscribeToTopic('id_$id');
      return const HomeownerBottomNavigationBar();
    } else if (role == '3' || role == '4') {
      await initializeFirebase();
      FirebaseMessaging.instance.subscribeToTopic('role_$role');
      FirebaseMessaging.instance.subscribeToTopic('id_$id');
      return const SecurityPersonnelBottomBar();
    } else {
      return const LoginPage();
    }
  }
  @override

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRolePage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // loading spinner until the Future completes
        } else {
          return snapshot.data ?? const CircularProgressIndicator(); // returns the Widget once Future completes
        }
      },
    );
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