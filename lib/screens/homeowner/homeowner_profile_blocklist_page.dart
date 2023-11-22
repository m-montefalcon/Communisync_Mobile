import 'package:communisyncmobile/backend/api/homeowner/BLF/submit_blocklists.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';

class BlocklistSettingsPage extends StatefulWidget {
  final User user;
  const BlocklistSettingsPage({super.key, required this.user});

  @override
  State<BlocklistSettingsPage> createState() => _BlocklistSettingsPageState();
}

class _BlocklistSettingsPageState extends State<BlocklistSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController last_nameController = TextEditingController();
  final TextEditingController contact_numberController = TextEditingController();
  final TextEditingController blocked_reasonController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocklist Settings'),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.app_blocking_rounded,
                      size: 150, color: Colors.green),
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
                          controller: first_nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: 'First Name',
                              border: InputBorder.none,
                              icon: Icon(Icons.person_rounded)),
                          validator: (value) {
                            {
                              if (value!.isEmpty) {
                                return 'Enter First Name';
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
                        child: TextFormField(
                          controller: last_nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: 'Last Name',
                              border: InputBorder.none,
                              icon: Icon(Icons.person_rounded)),
                          validator: (value) {
                            {
                              if (value!.isEmpty) {
                                return 'Enter Last Name';
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
                        child: TextFormField(
                          controller: contact_numberController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          maxLength: 11, // Limit the length to 11 characters
                          decoration: const InputDecoration(
                              hintText: 'Contact Number',
                              border: InputBorder.none,
                              icon: Icon(Icons.phone)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Contact Number';
                            } else if (value.length != 11) {
                              return 'Contact Number must be 11 characters';
                            } else {
                              return null;
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
                            controller: blocked_reasonController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'Blocked Reason',
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
                  loading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            onPressed: () async {
                              // Validate each field before printing the data
                              if (_formKey.currentState!.validate()) {
                                await submitBlockedlists(context, first_nameController.text, last_nameController.text, contact_numberController.text, blocked_reasonController.text);
                                // Print data if not empty
                                print('First Name: ${first_nameController.text}');
                                print('Last Name: ${last_nameController.text}');
                                print('Contact Number: ${contact_numberController.text}');
                                print('Blocked Reason: ${blocked_reasonController.text}');
                              }
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
