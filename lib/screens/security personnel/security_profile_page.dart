import 'package:communisyncmobile/backend/api/auth/logout_auth.dart';
import 'package:communisyncmobile/backend/api/auth/profile.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/constants/profile_widget.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_profile_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecurityProfilePage extends StatelessWidget {
  const SecurityProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: profileUser(), // Your API function to fetch user profile
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, display circular progress indicators
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // If data is available, display the user's profile using UserProfileWidget
            final user = snapshot.data!;
            return UserProfileWidget(user: user);
          } else {
            // Handle other cases
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

class UserProfileWidget extends StatefulWidget {
  final User user;

  const UserProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidget();
}

class _UserProfileWidget extends State<UserProfileWidget> {
  SnackBar buildErrorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String host = dotenv.get("API_HOST", fallback: "");

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 110,
            elevation: 0.0,
            flexibleSpace: ClipPath(
              clipper: AppBarCustomClipper(),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [
                    //     Colors.purple.shade800,
                    //     Colors.purple.shade500,
                    //   ],
                    // ),
                    color: Colors.green.shade700),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: FutureBuilder<User>(
          future: profileUser(), // Your API function to fetch user profile
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for data, display circular progress indicators
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // If there's an error, display an error message
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              // If data is available, display the user's profile using UserProfileWidget
              final user = snapshot.data!;
              return Builder(builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: user.photo != null
                              ? BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '$host/storage/' + user.photo!),
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 5.0,
                                  ),
                                )
                              : BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user-avatar.png'),
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 5.0,
                                  )),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 90,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.firstName + ' ' + user.lastName,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Personnel/Admin",
                          style: TextStyle(
                            color: Colors.black54.withOpacity(.3),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: ProfileWidget(
                                  icon: Icons.phone_iphone,
                                  title: '${user.contactNumber}',
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: ProfileWidget(
                                    icon: Icons.email,
                                    title: '${user.email}'),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
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
                                          builder: (context) =>
                                              UpdateProfileSecurity(
                                                  user: widget.user)));
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      buildErrorSnackBar(
                                          'An error occurred: $e'),
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
                );
              });
            } else {
              // Handle other cases
              return Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
