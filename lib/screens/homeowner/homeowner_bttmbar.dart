import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_complaints_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_dashboard_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_profile_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_qrcode_page.dart';
import 'package:flutter/material.dart';

class HomeownerBottomNavigationBar extends StatefulWidget {
  const HomeownerBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<HomeownerBottomNavigationBar> createState() => _HomeownerBottomNavigationBarState();
}

class _HomeownerBottomNavigationBarState extends State<HomeownerBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    ComplaintsPage(),
    QrCode(),
    AnnouncementPage(),
    ProfilePage(),
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
        selectedItemColor: Colors.purple,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 25,),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.wechat_rounded, size: 25,),
            label: 'Complain',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.qr_code_rounded, size: 35 , color: Colors.white),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates_rounded, size: 25,),
            label: 'Announce',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, size: 25,),
            label: 'Profile',
          ),
        ],

      ),
    );
  }
}
