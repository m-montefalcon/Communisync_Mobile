import 'package:communisyncmobile/screens/announcements_page.dart';
import 'package:communisyncmobile/screens/complaints_page.dart';
import 'package:communisyncmobile/screens/dashboard_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../screens/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  final items = const [
    Icon(
      Icons.home,
    ),
    Icon(
      Icons.wechat,
    ),
    Icon(
      Icons.tips_and_updates,
    ),
    Icon(
      Icons.person,
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: getSelectedWidget(index: index),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.purple,
        buttonBackgroundColor: Colors.transparent,
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
    );
  }
}

Widget getSelectedWidget({required int index}) {
  Widget widget;
  switch (index) {
    case 0:
      widget = const DashboardPage();
      break;

    case 1:
      widget = const ComplaintsPage();
      break;

    case 2:
      widget = const AnnouncementPage();
      break;

    default:
      widget = const ProfilePage();
      break;
  }
  return widget;
}
