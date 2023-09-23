import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpecificRequestVSTwo extends StatefulWidget {
  final Request request;

  const SpecificRequestVSTwo({Key? key, required this.request})
      : super(key: key);

  @override
  State<SpecificRequestVSTwo> createState() => _SpecificRequestVSTwoState();
}

String host = dotenv.get("API_HOST", fallback: "");

class _SpecificRequestVSTwoState extends State<SpecificRequestVSTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Info'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          widget.request.visitor.photo != null
              ? Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '$host/storage/' + widget.request.visitor.photo!),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.purple,
                        width: 5.0,
                      )),
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 120,
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          Center(
            child: Text(
              '${widget.request.visitor.firstName} ${widget.request.visitor.lastName}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
          ),
          Center(
            child: Text(
              'Visitor ID: ${widget.request.visitorId}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54.withOpacity(.3),
              ),
            ),
          ),
          // Text('ID: ${widget.request.id}'),
          const Divider(color: Colors.black, indent: 20, endIndent: 20,height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Icon(
                Icons.alternate_email,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.request.visitor.userName}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Icon(
                Icons.date_range,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.request.date}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Icon(
                Icons.home,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.request.destinationPerson}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Icon(
                Icons.call,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.request.visitor.contactNumber}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'I am with:',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              '${widget.request.visitMembers}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(color: Colors.black, indent: 20, endIndent: 20,height: 25),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text(
                    'Decline',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
