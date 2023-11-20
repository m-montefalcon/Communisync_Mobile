import 'package:communisyncmobile/screens/visitor/visitor_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:communisyncmobile/backend/api/visitor/request_ca.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../backend/model/models.dart';

class TapSpecificName extends StatefulWidget {
  final Homeowner homeowner;

  const TapSpecificName({Key? key, required this.homeowner}) : super(key: key);

  @override
  State<TapSpecificName> createState() => _TapSpecificNameState();
}

class _TapSpecificNameState extends State<TapSpecificName> {
  final List<Widget> _textFields = [];
  final List<TextEditingController> _controllers = [];
  List<String> _familyMemberChoices = [];
  String _selectedFamilyMember = ''; // To store the selected family member
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add an initial text field
    _textFields.add(_buildTextField(0));
    _initializeFamilyMembers();
  }

  void _initializeFamilyMembers() {
    _familyMemberChoices = [];

    if (widget.homeowner.familyMember != null) {
      String familyMembersString = widget.homeowner.familyMember!.toString();
      // Remove brackets and quotation marks
      familyMembersString = familyMembersString.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '');
      _familyMemberChoices.addAll(familyMembersString.split(',').map((e) => e.trim()));
    }

    // Always add the firstName and lastName as the first option
    _familyMemberChoices.insert(0, '${widget.homeowner.firstName} ${widget.homeowner.lastName}');
  }

  Widget _buildTextField(int index) {
    TextEditingController controller = TextEditingController();
    _controllers.add(controller);

    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                hintText: 'Name:',
              ),
            ),
          ),
        ),
        SizedBox(width: 5.0),
        IconButton(
          icon: const Icon(Icons.group_add_rounded, color: Colors.green),
          onPressed: () {
            setState(() {
              _textFields.insert(index + 1, _buildTextField(index + 1));
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.group_remove_rounded, color: Colors.red),
          onPressed: () {
            setState(() {
              _textFields.removeAt(index);
              _controllers.removeAt(index);
            });
          },
        ),
      ],
    );
  }

  void _acceptNames() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    // Create a list of strings from visitMembers TextEditingControllers
    List<String> visitMembers = [];
    for (TextEditingController controller in _controllers) {
      String name = controller.text;
      visitMembers.add('"$name"'); // Add quotation marks around each name
    }

    try {
      // Simulating an asynchronous operation, replace this with your actual logic
      await Future.delayed(Duration(seconds: 2));

      // Set loading state to false when the operation is complete
      setState(() {
        _isLoading = false;

        // Call the requestCa function with the necessary parameters
        requestCa(
          context,
          widget.homeowner.id, // Replace with the actual homeownerId property
          _selectedFamilyMember, // Use the selected family member
          visitMembers, // Pass the list of visit members with quotation marks
        );

        // Navigate to VisitorBottombar upon success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VisitorBottombar()),
        );
      });
    } catch (error) {
      // Handle any errors here
      print("Error: $error");

      // Set loading state to false even in case of an error
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(widget.homeowner.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 5),
            PopupMenuButton<String>(
              onSelected: (String selectedValue) {
                // Handle the selected value as needed
                setState(() {
                  _selectedFamilyMember = selectedValue; // Set the selected family member
                });
              },
              itemBuilder: (BuildContext context) {
                if (_familyMemberChoices.length > 1) {
                  return _familyMemberChoices.map((String member) {
                    return PopupMenuItem<String>(
                      value: member,
                      child: Text(member),
                    );
                  }).toList();
                } else {
                  // Handle the case when familyMember is null
                  return [
                    PopupMenuItem<String>(
                      value: 'No family members available',
                      child: Text('No family members available'),
                    )
                  ];
                }
              },
              child: ListTile(
                title: Text(
                  _selectedFamilyMember.isEmpty ? "Select Destination Person" : _selectedFamilyMember,
                  style: const TextStyle(fontSize: 18, color: Colors.white), // Text color
                ),
                tileColor: Colors.green, // Background color
                trailing: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white, // Icon color
                ),
              ),
            ),
            SizedBox(height: 10.0),

            // Display the selected family member
            Row(
              children: [
                Text('Selected Family Member: ', style: TextStyle(fontSize: 15,)),
                Text('$_selectedFamilyMember', style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold))
              ],
            ),

            SizedBox(height: 16.0),

            Expanded(
              child: ListView.separated(
                itemCount: _textFields.length,
                itemBuilder: (context, index) {
                  return _textFields[index];
                },
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
              ),
            ),
            SizedBox(height: 16.0),
            Stack(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(310, 45),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isLoading ? null : _acceptNames, // Disable button when loading
                  child: Text(
                    'Send Request',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(), // Display the circular progress indicator
                  ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
