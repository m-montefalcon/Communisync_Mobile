import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:communisyncmobile/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';

import 'firebase_options.dart';

void main() async {
  // Load environment variables from the dotenv file
  await dotenv.load(fileName: "dotenv");
  try {

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
  } catch (e) {
  }

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
        notificationLayout: NotificationLayout.BigPicture,
        displayOnForeground: true,
      ),
    );
  } else {
  }
}
