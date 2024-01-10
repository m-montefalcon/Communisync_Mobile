import 'package:flutter/material.dart';
import 'package:communisyncmobile/backend/api/visitor/request_ca.dart';


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
  DateTime? _selectedFromDate;
  DateTime? _selectedUntilDate;

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
      // Convert the selected dates to strings
      String fromDateString = _selectedFromDate != null ? formattedDate(_selectedFromDate!) : 'N/A';
      String untilDateString = _selectedUntilDate != null ? formattedDate(_selectedUntilDate!) : 'N/A';
      // Call the requestCa function with the necessary parameters
      await requestCa(
        context,
        widget.homeowner.id, // Replace with the actual homeownerId property
        _selectedFamilyMember, // Use the selected family member
        visitMembers, // Pass the list of visit members with quotation marks
        fromDateString, // Pass the 'From' date string
        untilDateString, // Pass the 'Until' date string

      );
      print(widget.homeowner.id);
      print(_selectedFamilyMember);
      print(visitMembers);
      print(fromDateString);
      print(untilDateString);


      // Set loading state to false when the operation is complete
      setState(() {
        _isLoading = false;
      });

    } catch (error) {
      // Handle any errors here

      // Set loading state to false even in case of an error
      setState(() {
        _isLoading = false;
      });
    }
  }
  String formattedDate(DateTime? dateTime) {
    return dateTime != null
        ? '${dateTime.toLocal().year}-${dateTime.toLocal().month}-${dateTime.toLocal().day}'
        : '';
  }
  bool isDateOrderValid() {
    return _selectedFromDate != null && _selectedUntilDate != null &&
        (_selectedFromDate!.isBefore(_selectedUntilDate!) || _selectedFromDate == _selectedUntilDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [


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


            SizedBox(height: 10.0),
            Text(
              'SELECT DATE RANGES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: Colors.green,
                              colorScheme: ColorScheme.light(primary: Colors.green),
                              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedFromDate = picked;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'From: ${formattedDate(_selectedFromDate)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            // Until Date Picker
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: Colors.green,
                              colorScheme: ColorScheme.light(primary: Colors.green),
                              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedUntilDate = picked;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'Until: ${formattedDate(_selectedUntilDate)}',
                  style: TextStyle(fontSize: 16),
                ),
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
                  onPressed: _isLoading || _selectedFamilyMember.isEmpty || !isDateOrderValid()
                      ? null
                      : _acceptNames, // Disable button when loading, no selected destination person, or invalid date order
                  child: Text(
                    isDateOrderValid() ? 'Send Request' : 'Invalid date order',
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
