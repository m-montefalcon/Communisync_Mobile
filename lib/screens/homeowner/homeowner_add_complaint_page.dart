import 'dart:io';

import 'package:communisyncmobile/backend/api/homeowner/CF/submit_complaints.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddComplaintsPage extends StatefulWidget {
  const AddComplaintsPage({Key? key}) : super(key: key);

  @override
  State<AddComplaintsPage> createState() => _AddComplaintsPageState();
}

class _AddComplaintsPageState extends State<AddComplaintsPage> {
  final _complaintformKey = GlobalKey<FormState>();
  final TextEditingController _complaintTitle = TextEditingController();
  final TextEditingController _complaintDesc = TextEditingController();
  final TextEditingController _complaintDate = TextEditingController();
  final TextEditingController _complaintPhoto = TextEditingController();
  final TextEditingController _complaintPhotoPath = TextEditingController();

  DateTime? _selectedDate;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  Future<void> _getImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imagePath = image.path;
      print('Image path: $imagePath'); // Add this line to check the image path
      setState(() {
        _complaintPhotoPath.text = imagePath;
      });
    }
  }


  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       _complaintDate.text = DateFormat('MM/dd/yyyy').format(picked);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Complaint'),
      ),
        body: Form(
            key: _complaintformKey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.report_problem_rounded,
                        size: 150,
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
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
                              controller: _complaintTitle,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  hintText: 'Complaint Title',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.title_rounded)),
                              validator: (value) {
                                {
                                  if (value!.isEmpty) {
                                    return 'Enter title';
                                  } else {
                                    return null;
                                  }
                                }
                              },
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
                            child: Container(
                              height: 150,
                              child: TextFormField(
                                controller: _complaintDesc,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    hintText: 'Descriptions',
                                    border: InputBorder.none,
                                    icon: Icon(Icons.description_rounded)),
                                validator: (value) {
                                  {
                                    if (value!.isEmpty) {
                                      return 'Enter descriptions';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

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
                            child: Row(
                              children: [
                                Icon(Icons.insert_photo_rounded),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _complaintPhotoPath,
                                    readOnly: true,
                                    onTap: _getImage,
                                    decoration: const InputDecoration(
                                      hintText: 'Attach photo here',
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Attach photo';
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator()  // Display the circular progress indicator when loading
                              : const Text(
                            'Submit Complain',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: _isLoading
                              ? null  // Disable the button when loading
                              : () async {
                            // Set loading state to true when the button is pressed
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              // Perform the complaint submission logic
                              await submitComplaint(
                                context,
                                _complaintTitle.text,
                                _complaintDesc.text,
                                _complaintPhotoPath.text,
                              );

                              // Navigate to HomeownerBottomBar after successful submission
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeownerBottomNavigationBar()),
                              );
                            } catch (error) {
                              // Handle errors here
                              print("Error: $error");
                            } finally {
                              // Set loading state to false when the complaint submission is complete
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}
