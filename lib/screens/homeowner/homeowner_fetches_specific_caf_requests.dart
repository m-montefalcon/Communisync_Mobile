import 'package:communisyncmobile/backend/model/request_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpecificRequestVSTwo extends StatefulWidget {
  final Request request;

  const SpecificRequestVSTwo({Key? key, required this.request}) : super(key: key);

  @override
  State<SpecificRequestVSTwo> createState() => _SpecificRequestVSTwoState();
}
String host = dotenv.get("API_HOST", fallback: "");

class _SpecificRequestVSTwoState extends State<SpecificRequestVSTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: ListView(
       children: [
        Text('ID: ${widget.request.id}'),
        Text('visitorId: ${widget.request.visitorId}'),
        Text('date: ${widget.request.date}'),
        Text('destinationperson: ${widget.request.destinationPerson}'),
        Text('members: ${widget.request.visitMembers}'),
        Text('username: ${widget.request.visitor.userName}'),
        Text('name: ${widget.request.visitor.firstName} ${widget.request.visitor.lastName}'),
        Text('username: ${widget.request.visitor.contactNumber}'),
         widget.request.visitor.photo != null ?
              Image.network('$host/storage/' + widget.request.visitor.photo! )
             : Container(),




       ],
      ),
    );
  }
}
