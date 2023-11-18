import 'package:communisyncmobile/backend/api/homeowner/CAF/accept_request.dart';
import 'package:communisyncmobile/backend/api/homeowner/CAF/decline_request.dart';
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

bool _isLoading = false;
bool _isLoading2 = false;

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
          Container(
            decoration: widget.request.visitor.photo != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '$host/storage/' + widget.request.visitor.photo!),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 5.0,
                    ),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/user-avatar.png'),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 5.0,
                    )),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 120,
            ),
          ),
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
          const Divider(
              color: Colors.black, indent: 20, endIndent: 20, height: 10),
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
              ' ${widget.request.visitMembers?.map((member) => member.toString()).join(', ')?.replaceAll(RegExp(r'[\[\]"]'), '') ?? 'No members'} ', // Use null-aware operator
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),



          const Divider(
              color: Colors.black, indent: 20, endIndent: 20, height: 25),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await acceptRequestCa(context, widget.request.id);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : const Text('Accept'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading2 = true;
                    });
                    try {
                      await declineRequestCa(context, widget.request.id);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    } finally {
                      setState(() {
                        _isLoading2 = false;
                      });
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: _isLoading2
                      ? CircularProgressIndicator()
                      : const Text('Decline'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
