import 'package:communisyncmobile/constants/profile_widget.dart';
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/register_page.dart';
import 'package:flutter/material.dart';

class VisitorProfilePage extends StatefulWidget {
  const VisitorProfilePage({Key? key}) : super(key: key);

  @override
  State<VisitorProfilePage> createState() => _VisitorProfilePageState();
}

class _VisitorProfilePageState extends State<VisitorProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 75),
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple,
                    width: 3.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage:
                  ExactAssetImage('assets/images/user-avatar.png'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "John de Bisita",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
              Text(
                "Visitor",
                style: TextStyle(
                  color: Colors.black54.withOpacity(.3),
                ),
              ),
              SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.person,
                        title: 'bisitajohn14',
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.cake,
                        title: 'July 31, 2001',
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.phone_iphone,
                        title: '+639992874835',
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.email,
                        title: 'bisita.john@gmail.com',
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.settings,
                        title: 'Edit Profile',
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
