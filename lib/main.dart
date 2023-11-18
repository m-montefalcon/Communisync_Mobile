import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';

import 'firebase_options.dart';

void main() async {
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

  // Run the app
  runApp(const MyApp());
}

class CustomOverlay extends StatelessWidget {
  final String? title;
  final String? body;

  const CustomOverlay({Key? key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.green, // Set your desired color
      child: ListTile(
        title: Text(
          title ?? '',
          style: TextStyle(
            color: Colors.white, // Set text color
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          body ?? '',
          style: TextStyle(
            color: Colors.white, // Set text color
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CommuniSync',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const RootPage(),
      ),
    );
  }
}

void Notify() async {
  // Local notification
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Simple Notification',
      body: 'Simple body',
      bigPicture: 'assets://images/protocoderlogo.png',
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void showAwesomeNotification(String? title, String? body) async {
  // Check if notifications are allowed
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

  if (isAllowed) {
    // Show awesome notification
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title ?? '',
        body: body ?? '',
        bigPicture: 'resource://drawable/app_icon',
        notificationLayout: NotificationLayout.BigPicture,
        displayOnForeground: true,
      ),
    );
  } else {
    print("Notifications are not allowed");
  }
}
