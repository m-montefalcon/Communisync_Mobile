import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddComplaintsPage extends StatefulWidget {
  const AddComplaintsPage({Key? key}) : super(key: key);

  @override
  State<AddComplaintsPage> createState() => _AddComplaintsPageState();
}

class _AddComplaintsPageState extends State<AddComplaintsPage> {
  final _compalinformKey = GlobalKey<FormState>();
  final TextEditingController _complaintTitle = TextEditingController();
  final TextEditingController _complaintDesc = TextEditingController();
  final TextEditingController _complaintDate = TextEditingController();
  final TextEditingController _complaintPhoto = TextEditingController();

  DateTime? _selectedDate;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _complaintPhoto.text = image.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _complaintDate.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Complaint'),
      ),
        body: Form(
            key: _compalinformKey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.live_help_rounded,
                        size: 120,
                        color: Colors.purple,
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
                                  labelText: 'Complaint Title',
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
                                    labelText: 'Descriptions',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Icon(Icons.date_range_rounded),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _complaintDate,
                                    keyboardType: TextInputType.datetime,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    // Set the text field as read-only
                                    onTap: () {
                                      _selectDate(
                                          context); // Add a function to handle date selection
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Date',
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter date';
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
                            child: Row(
                              children: [
                                Icon(Icons.insert_photo_rounded),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _complaintPhoto,
                                    readOnly: true,
                                    onTap: _getImage,
                                    decoration: const InputDecoration(
                                      labelText: 'Attach photo/s here',
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
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Submit Complain',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            )));
  }
}
