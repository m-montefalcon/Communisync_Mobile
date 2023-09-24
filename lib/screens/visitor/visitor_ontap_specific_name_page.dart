import 'package:flutter/material.dart';

class TapSpecificName extends StatefulWidget {
  const TapSpecificName({Key? key}) : super(key: key);

  @override
  State<TapSpecificName> createState() => _TapSpecificNameState();
}

class _TapSpecificNameState extends State<TapSpecificName> {
  final List<Widget> _textFields = [];

  @override
  void initState() {
    super.initState();
    // Add an initial text field
    _textFields.add(_buildTextField(0));
  }

  Widget _buildTextField(int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                hintText: 'Name:',
                // border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.0),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.green),
          onPressed: () {
            setState(() {
              _textFields.insert(index + 1, _buildTextField(index + 1));
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.red),
          onPressed: () {
            setState(() {
              _textFields.removeAt(index);
            });
          },
        ),
      ],
    );
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(310,45),
                  backgroundColor: Colors.purple[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              child: const Text(
                'Accept',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
