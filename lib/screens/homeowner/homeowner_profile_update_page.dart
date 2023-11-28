
import 'dart:convert';
import 'dart:io';

import 'package:communisyncmobile/backend/api/auth/update_profile_picture.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/api/auth/update_profile_as_homeowner.dart';

class UpdateProfileHomeowner extends StatefulWidget {
  final User user;
  const UpdateProfileHomeowner({super.key, required this.user});

  @override
  State<UpdateProfileHomeowner> createState() => _UpdateProfileHomeownerState();
}
@override




class _UpdateProfileHomeownerState extends State<UpdateProfileHomeowner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profilePicturePath = TextEditingController();
  final TextEditingController _blockNumberController = TextEditingController();
  final TextEditingController _lotNumberController = TextEditingController();
  bool _isManualVisitEnabled = false; // Initialize to false


  // final TextEditingController _confirmPasswordController = TextEditingController();
  File? _profilePicture;



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
  bool _isHovered = false;

  List<TextEditingController> _controllers = [];
  final List<Widget> _textFields = [];

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
    if (widget.user.photo != null) {
      _profilePicturePath.text = widget.user.photo!;
    } else {
      // Handle the case where widget.user.photo is null
      // You can set a default value or do nothing depending on your requirements
      // For example:
      // _profilePicturePath.text = 'default_image_path.png';
      // or
      // _profilePicturePath.text = '';
    }
    _blockNumberController.text = widget.user.blockNo.toString();
    _lotNumberController.text = widget.user.lotNo.toString();

    _isManualVisitEnabled = widget.user.manualVisitOption == 1;
    List<String> familyMembers = (jsonDecode(widget.user.familyMember ?? '[]') as List).map((item) => item.toString()).toList();

    if (familyMembers.isEmpty) {
      TextEditingController controller = TextEditingController();
      _controllers.add(controller);
      _textFields.add(_buildTextField(0, controller));
    } else {
      for (var i = 0; i < familyMembers.length; i++) {
        TextEditingController controller = TextEditingController(text: familyMembers[i]);
        _controllers.add(controller);
        _textFields.add(_buildTextField(i, controller));
      }
    }

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
  Widget _buildTextField(int index, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _textFields.insert(index + 1, _buildTextField(index + 1, TextEditingController()));
                _controllers.insert(index + 1, TextEditingController());
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _textFields.removeAt(index);
                _controllers.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String host = dotenv.get("API_HOST", fallback: "");
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
                    onTap: getImageProfilePic,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.green,
                      backgroundImage: (_profilePicture != null)
                          ? FileImage(_profilePicture!) as ImageProvider<Object>
                          : ((widget.user.photo != null)
                          ? NetworkImage('$host/storage/${widget.user.photo}')
                          : null),
                      child: Visibility(
                        visible: _profilePicture == null && widget.user.photo == null,
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
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
                            controller: _emailController,
                            // maxLength: 11,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'user@communisync.com',
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
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: '09xxxxxxxxx',
                                border: InputBorder.none,
                                icon: Icon(Icons.phone_android)),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter your contact number';
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _blockNumberController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Block Number',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.numbers),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a block number.';
                                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                                    return 'Please enter a valid block number.';
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
                                controller: _lotNumberController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Lot Number',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.numbers),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a lot number.';
                                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                                    return 'Please enter a valid lot number.';
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
                              'Manual Visit Option',
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.lock_person_rounded),
                            SizedBox(width: 5),
                            Text('Manual Visit Option'),
                            SizedBox(width: 10), // Adjust the spacing as needed
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isHovered = !_isHovered;
                                });
                              },
                              child: Icon(Icons.help_outline), // Replace 'Icons.help_outline' with the desired question mark icon
                            ),
                            Spacer(), // This will push the Switch to the right (end)
                            Switch(
                              value: _isManualVisitEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _isManualVisitEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_isHovered)
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
                      child: Text(
                        'Toggle this switch to enable manual visit option. \n'
                            'Visitors will be able to visit you without QR code',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

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
                              'Family Members',
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
                  const SizedBox(height: 5),

                  Column(
                    children: _textFields,
                  ),
                  const SizedBox(height: 10),
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
                        'Update Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        try {
                          List<String> familyMembers = [];
                          for (TextEditingController controller in _controllers) {
                            String name = controller.text;
                            familyMembers.add('"$name"'); // Add quotation marks around each name
                          }

                          // Call the updateProfileAsHomeowner function with the collected parameters
                          await updateProfileAsHomeowner(
                            context,
                            _profilePicturePath.text,
                            _userNameController.text,
                            _firstNameController.text,
                            _lastNameController.text,
                            _emailController.text,
                            _contactNumber.text,
                            _blockNumberController.text,
                            _lotNumberController.text,
                            _isManualVisitEnabled,
                            familyMembers,
                          );

                        } catch (e) {
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
