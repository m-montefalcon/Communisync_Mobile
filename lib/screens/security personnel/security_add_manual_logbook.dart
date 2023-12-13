import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';


import '../../backend/api/personnel/mvo_add.dart';
import '../../backend/model/models.dart';

class AddManualLogbookPage extends StatefulWidget {
  final Homeowner homeowner;

  const AddManualLogbookPage({Key? key, required this.homeowner}) : super(key: key);

  @override
  _AddManualLogbookPageState createState() => _AddManualLogbookPageState();
}

class _AddManualLogbookPageState extends State<AddManualLogbookPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
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
      familyMembersString =
          familyMembersString.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '');
      _familyMemberChoices.addAll(familyMembersString.split(',').map((e) => e.trim()));
    }

    // Always add the firstName and lastName as the first option
    _familyMemberChoices.insert(0, '${widget.homeowner.firstName} ${widget.homeowner.lastName}');
  }


  Widget _buildTextField(int index) {
    TextEditingController controller = TextEditingController();
    _controllers.insert(index, controller); // Insert controller at the given index

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

  Widget _buildPhoneNumberInput() {
    return Container(
      padding: EdgeInsets.only(right: 100),
      child: TextField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          hintText: 'Phone Number:',
        ),
        maxLength: 11, // Set the maximum length to 11 characters

      ),
    );
  }
  void _acceptNames() async {
    setState(() {
      _isLoading = true;
    });

    // Create a list of strings from visitMembers TextEditingControllers
    List<String> visitMembers = [];
    for (TextEditingController controller in _controllers) {
      String name = controller.text;
      visitMembers.add('"$name"');
    }

    // Add the phone number to the list
    String phoneNumber = _phoneNumberController.text;

    try {
      await MvoAdd(
        context,
        widget.homeowner.id,
        phoneNumber,
        _selectedFamilyMember,
        visitMembers,
      );

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

      // Show an error message in a SnackBar using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Manually Logbook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Select who to visit',style: TextStyle(fontSize: 15,)),

            PopupMenuButton<String>(
              onSelected: (String selectedValue) {
                // Handle the selected value as needed
                setState(() {
                  _selectedFamilyMember = selectedValue; // Set the selected family member
                });
              },
              itemBuilder: (BuildContext context) {
                if (_familyMemberChoices.isNotEmpty) {
                  return _familyMemberChoices.map((String member) {
                    return PopupMenuItem<String>(
                      value: member,
                      child: Text(member),
                    );
                  }).toList();
                } else {
                  // Handle the case when familyMember is null or empty
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
                  _selectedFamilyMember.isEmpty
                      ? "Select Destination Person"
                      : _selectedFamilyMember,
                    style: const TextStyle(fontSize: 18, color: Colors.white)
                ),
                tileColor: Colors.green,
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),

            // Display the selected family member
            Row(
              children: [
                Text('Selected Family Member: ', style: TextStyle(fontSize: 15,)),
                Text('$_selectedFamilyMember', style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 16.0),
            _buildPhoneNumberInput(),



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
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (_isLoading || _selectedFamilyMember.isEmpty) ? null : _acceptNames,
                  // Disable the button if _isLoading is true or _selectedFamilyMember is empty
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),

          ],
        ),
      ),
    );
  }

}
