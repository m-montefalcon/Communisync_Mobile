import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:io';

import '../backend/api/auth/register_auth.dart';
import 'login_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final TextEditingController _profilePicturePath = TextEditingController();

  // final TextEditingController _confirmPasswordController = TextEditingController();
  File? _profilePicture;
  String host = dotenv.get("API_HOST", fallback: "");
  String termsAndCondition = dotenv.get("TERMS_AND_CONDITION", fallback: "");
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
  bool agreeToTerms = false;

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

  Future<void> _pickProfilePicture() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _profilePicture = imageFile;
        _profilePicturePath.text = pickedFile.path;
      });
    }
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
                  GestureDetector(
                    onTap: _pickProfilePicture,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.green,
                      backgroundImage: _profilePicture != null
                          ? FileImage(_profilePicture!)
                          : null,
                      child: _profilePicture == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
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
                                hintText: 'Username',
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
                                hintText: 'First Name',
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
                                hintText: 'Last Name',
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
                                hintText: 'Contact Number',
                                border: InputBorder.none,
                                icon: Icon(Icons.phone)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter a valid phone number.';
                              } else if (value.length != 11) {
                                return 'Phone number must be 11 digits.';
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'Email',
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
                            hintText: 'Password',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                agreeToTerms = value!;
                              });
                            }),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                agreeToTerms = !agreeToTerms;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text:
                                      'By selecting Sign Up, you are confirming that you have read and agree to the CommuniSync ',
                                    ),
                                    TextSpan(
                                      text:
                                      'Terms of Conditions and Privacy Statement.',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchURL(
                                              'your_link_here'); // Replace with your actual URL
                                        },
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  loading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: Colors.green,
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () async {
                                if (!agreeToTerms) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please accept the Terms and Conditions.')));
                                  return;
                                }

                                setState(() {
                                  loading = true;
                                });

                                try {
                                  await registerUser(
                                    context,
                                    _userNameController.text,
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _contactNumber.text,

                                    _emailController.text,
                                    _passwordController.text,
                                    _profilePicturePath.text,
                                  );
                                  print(
                                      'profile pic path ${_profilePicturePath}');
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('($e)')),
                                  );
                                }

                                if (_contactNumber.text.length != 11) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone number must be 11 digits.')));

                                }

                                setState(() {
                                  loading = false;
                                });
                              }),
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
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await launchUrlString('$host$termsAndCondition')) {
      await launchUrlString('$host$termsAndCondition');
    } else {
      throw 'Could not launch Terms and Condition';
    }
  }
}
