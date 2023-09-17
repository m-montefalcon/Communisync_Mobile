import 'package:communisyncmobile/backend/api/auth/logout_auth.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_payment_page.dart';
import 'package:communisyncmobile/constants/profile_widget.dart';
import 'package:communisyncmobile/screens/login_page.dart';
import 'package:communisyncmobile/screens/register_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SnackBar buildErrorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
  }
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
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentHistory()));
                    },
                    icon: const Icon(Icons.payments, color: Colors.black54, size: 35),
                  ),
                ],
              ),
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
                "Juan dela Cruz",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
              Text(
                "Homeowner",
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
                        title: 'juandelacruz23',
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
                        title: 'December 32, 2023',
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
                        title: '+639981725564',
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
                        title: 'juan@communisync.com',
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
                      onTap: () async {
                        try {
                          await logout(context);
                        } catch (e) {
                          print('Exception caught: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildErrorSnackBar('An error occurred: $e'),
                          );
                        }
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
