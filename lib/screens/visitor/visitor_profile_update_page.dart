

import 'dart:io';

import 'package:communisyncmobile/backend/api/auth/update_profile.dart';
import 'package:communisyncmobile/backend/api/auth/update_profile_picture.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileVisitor extends StatefulWidget {
  final User user;

  const UpdateProfileVisitor({super.key, required this.user});

  @override
  State<UpdateProfileVisitor> createState() => _UpdateProfileVisitorState();
}

class _UpdateProfileVisitorState extends State<UpdateProfileVisitor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profilePicturePath = TextEditingController();


  File? _profilePicture;

  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool loading = false;


  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    confirmPasswordVisible = false;
    _userNameController.text = widget.user.userName;
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _emailController.text = widget.user.email;
    _contactNumber.text = widget.user.contactNumber;
    _profilePicturePath.text = widget.user.photo!;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactNumber.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  SnackBar buildErrorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImageProfilePic() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imagePath = image.path;

      try {
        _profilePicturePath.text = image.path;

        // Show a circular progress indicator while uploading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(), // Add circular progress indicator
            );
          },
        );

        // Upload the image to the server
        await updateProfilePicture(context, image.path);

        // Set the updated profile picture URL in the local state
        setState(() {
          _profilePicturePath.text = image.path;
        });

        // Close the progress indicator dialog

      } catch (e) {
        print('Error uploading profile picture: $e');
        // Handle the error, e.g., show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload profile picture. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );

        // Close the progress indicator dialog
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String host = dotenv.get("API_HOST", fallback: "");
    return  Scaffold(
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
                    onTap: getImageProfilePic,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.purple,
                      backgroundImage: _profilePicture != null
                          ? FileImage(_profilePicture!) as ImageProvider<Object>
                          : (widget.user.photo != null
                          ? NetworkImage('$host/storage/${widget.user.photo}')
                          : null),

                      child: _profilePicture == null && widget.user.photo == null
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
                    'Update Profile',
                    style: TextStyle(fontSize: 20),
                  ),


                  const SizedBox(height: 30),


                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _firstNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.person_rounded),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                    return 'Please enter your first name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _lastNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Last Name',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.person_rounded),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                    return 'Please enter your last name.';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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

                  const SizedBox(height: 10),

                  const SizedBox(height: 10),









                  const SizedBox(height: 10),
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
                        'Update Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        try {


                          // Call the updateProfileAsHomeowner function with the collected parameters
                          await UpdateProfile(
                            context,
                            _userNameController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                            _emailController.text,
                            _contactNumber.text,

                          );

                          // Print a message after the function call if needed
                          print('updateProfileAsHomeowner function called successfully');
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildErrorSnackBar('$e'),
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
