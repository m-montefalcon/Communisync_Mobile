import 'package:communisyncmobile/backend/api/personnel/accept_qr.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VisitorFullInfoPage extends StatefulWidget {
  final RequestQr requestQr;
  const VisitorFullInfoPage({Key? key,  required this.requestQr}) : super(key: key);

  @override
  State<VisitorFullInfoPage> createState() => _VisitorFullInfoPageState();
}

String host = dotenv.get("API_HOST", fallback: "");


class _VisitorFullInfoPageState extends State<VisitorFullInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Information'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          Container(
            decoration: widget.requestQr.visitor.photo != null
                ? BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '$host/storage/' + widget.requestQr.visitor.photo!),
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.purple,
                width: 5.0,
              ),
            )
                : BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/user-avatar.png'),
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
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              '${widget.requestQr.visitor.firstName} ${widget.requestQr.visitor.lastName}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
          ),
          Center(
            child: Text(
              'Visitor ID: ${widget.requestQr.visitor.id}',
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
                ': ${widget.requestQr.visitor.userName}',
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
                Icons.email,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.requestQr.visitor.email}',
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
                ': ${widget.requestQr.visitor.contactNumber}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
              color: Colors.black, indent: 20, endIndent: 20, height: 25),
          Center(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await acceptQr(context, widget.requestQr.id);
                    } catch (e) {}
                  },
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SecurityPersonnelBottomBar(),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  },
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  child: const Text('Decline'),
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
