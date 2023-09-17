import 'package:communisyncmobile/screens/register_page.dart';
import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:communisyncmobile/backend/api/auth/login_auth.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = true;
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  SnackBar buildErrorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello there!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Welcome to CommuniSync',
                    style: TextStyle(fontSize: 20),
                  ),
                  // Image.asset(
                  //   'assets/CommuniSyncLogo.png',width: 300),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'Username',
                                border: InputBorder.none,
                                icon: Icon(Icons.alternate_email_outlined)),
                            // validator: (value) {
                            //   if(value!.isEmpty || !RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}').hasMatch(value)) {
                            //     return 'Please enter your username.';
                            //   } else {
                            //     return null;
                            //   }
                            // }
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                            icon: const Icon(Icons.key_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password.';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  if (loading) const CircularProgressIndicator() else Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.purple[400],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10)
                          )
                      ),
                      icon: const Icon(
                        Icons.local_activity,
                        size: 0,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),

                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          try {
                            await loginUser(
                              context,
                              usernameController.text,
                              passwordController.text,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              buildErrorSnackBar('An error occurred: $e'),
                            );
                          } finally {
                            setState(() {
                              loading = false;
                            });
                          }
                        } else {
                          print('Please fill in all fields');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()
                              )
                          );
                        },
                        child: const Text(
                          'Register here!',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
