import 'package:flutter/material.dart';

class GetVerifiedVisitor extends StatefulWidget {
  const GetVerifiedVisitor({Key? key}) : super(key: key);

  @override
  State<GetVerifiedVisitor> createState() => _GetVerifiedVisitorState();
}

class _GetVerifiedVisitorState extends State<GetVerifiedVisitor> {
  final _getverifiedformKey = GlobalKey<FormState>();
  final TextEditingController _userID = TextEditingController();
  final TextEditingController _blockNo = TextEditingController();
  final TextEditingController _lotNo = TextEditingController();
  List<TextEditingController> _controllers = [];
  final List<Widget> _textFields = [];

  @override
  void initState() {
    super.initState();
    _textFields.add(_buildTextField(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Verified'),
      ),
      body: Form(
        key: _getverifiedformKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    size: 120,
                    color: Colors.purple,
                  ),
                  SizedBox(height: 15),
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
                          controller: _userID,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              labelText: 'User ID',
                              border: InputBorder.none,
                              icon: Icon(Icons.title_rounded)),
                          validator: (value) {
                            {
                              if (value!.isEmpty) {
                                return 'Enter User ID';
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
                          controller: _blockNo,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              labelText: 'Block Number',
                              border: InputBorder.none,
                              icon: Icon(Icons.title_rounded)),
                          validator: (value) {
                            {
                              if (value!.isEmpty) {
                                return 'Enter Block Number';
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
                          controller: _lotNo,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              labelText: 'Lot Number',
                              border: InputBorder.none,
                              icon: Icon(Icons.title_rounded)),
                          validator: (value) {
                            {
                              if (value!.isEmpty) {
                                return 'Enter Lot Number';
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
                  Column(
                    children: _textFields,

                  ),
                  const SizedBox(height: 10),
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
                        'Get Verified',
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
        ),
      ),
    );
  }

  Widget _buildTextField(int index) {
    TextEditingController controller = TextEditingController();
    _controllers.add(controller);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SizedBox(
              height: 55,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  hintText: 'Name:',
                ),
              ),
            ),
          ),
        ),
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
              _controllers.removeAt(index);
            });
          },
        ),
        SizedBox(width: 20.0),
      ],
    );
  }
  Widget buildTextFieldListView() {
    return Expanded(
      child: ListView.separated(
        itemCount: _textFields.length,
        itemBuilder: (context, index) {
          return _textFields[index];
        },
        separatorBuilder: (context, index) => SizedBox(height: 8.0),
      ),
    );
  }

}
