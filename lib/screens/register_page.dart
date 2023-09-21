import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../backend/api/auth/register_auth.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactNumber.dispose();
    _passwordController.dispose();
    // _confirmPasswordController.dispose();
    super.dispose();
  }


  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool loading = false;


  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    confirmPasswordVisible = false;
  }

  SnackBar buildErrorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.face,
                    size: 120,
                    color: Colors.purple,
                  ),
                  const Text(
                    'CommuniSync',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Register here with your info',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
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
                            controller: _userNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: InputBorder.none,
                                icon: Icon(Icons.person_rounded)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[a-z][A-Z]').hasMatch(value)) {
                                return 'Please enter your username';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'First Name',
                                border: InputBorder.none,
                                icon: Icon(Icons.person_rounded)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[a-z][A-Z]').hasMatch(value)) {
                                return 'Please enter your first name';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Last Name',
                                border: InputBorder.none,
                                icon: Icon(Icons.person_rounded)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[a-z][A-Z]').hasMatch(value)) {
                                return 'Please enter your last name.';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            controller: _contactNumber,
                            // maxLength: 11,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Contact Number',
                                hintText: '09xxxxxxxxx',
                                border: InputBorder.none,
                                icon: Icon(Icons.phone)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter your phone number.';
                              } else {
                                // return null;
                                value.length < 11
                                    ? 'Required 11 numbers'
                                    : null;
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                                icon: Icon(Icons.alternate_email_outlined)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                      .hasMatch(value)) {
                                return 'Please enter your email.';
                              } else {
                                return null;
                              }
                            }),
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
                          controller: _passwordController,
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
                  const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey[200],
                  //         border: Border.all(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15),
                  //       child: TextFormField(
                  //         // controller: _confirmPasswordController,
                  //         obscureText: !confirmPasswordVisible,
                  //         keyboardType: TextInputType.text,
                  //         textInputAction: TextInputAction.done,
                  //         decoration: InputDecoration(
                  //           labelText: 'Confirm Password',
                  //           border: InputBorder.none,
                  //           icon: const Icon(Icons.key_outlined),
                  //           suffixIcon: IconButton(
                  //             icon: Icon(
                  //                 confirmPasswordVisible
                  //                     ? Icons.visibility
                  //                     : Icons.visibility_off,
                  //                 color: Colors.grey),
                  //             onPressed: () {
                  //               setState(() {
                  //                 confirmPasswordVisible =
                  //                     !confirmPasswordVisible;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //         validator: (val) => val != _passwordController.text
                  //             ? 'Password does not match.'
                  //             : null,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),

                  loading
                      ? const CircularProgressIndicator()
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(
                        Icons.app_registration_outlined,
                        size: 0,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        try {
                          await registerUser(
                            context,
                            _userNameController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                            _emailController.text,
                            _contactNumber.text,
                            _passwordController.text,
                          );
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildErrorSnackBar('An error occurred: $e'),
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('I am now a member. ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
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
