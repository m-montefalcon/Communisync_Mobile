import 'package:communisyncmobile/screens/visitor/visitor_annoucement_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_dashboard_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_profile_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_search_homeowner_page.dart';
import 'package:flutter/material.dart';

class VisitorBottombar extends StatefulWidget {
  const VisitorBottombar({Key? key}) : super(key: key);

  @override
  State<VisitorBottombar> createState() => _VisitorBottombarState();
}

class _VisitorBottombarState extends State<VisitorBottombar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    VisitorDashboardPage(),
    VisitorAnnouncementPage(),
    VisitorQrCodePage(),
    VisitorProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 25,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.tips_and_updates_rounded,
              size: 25,
            ),
            label: 'Announce',
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded,
                size: 35),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 25,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
