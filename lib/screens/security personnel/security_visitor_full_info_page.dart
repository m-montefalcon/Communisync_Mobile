import 'package:communisyncmobile/backend/api/personnel/accept_qr.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_bttmbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class VisitorFullInfoPage extends StatefulWidget {
  final RequestQr requestQr;
  const VisitorFullInfoPage({Key? key,  required this.requestQr}) : super(key: key);

  @override
  State<VisitorFullInfoPage> createState() => _VisitorFullInfoPageState();
}

String host = dotenv.get("API_HOST", fallback: "");

bool isLoadingAccept = false;
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
                color: Colors.green,
                width: 5.0,
              ),
            )
                : BoxDecoration(
                image: const DecorationImage(
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
              '${widget.requestQr.visitor.firstName} ${widget.requestQr.visitor.lastName}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
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
                Icons.date_range,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Visit Date Ranges \nFrom : ${DateFormat('MMMM dd yyyy').format(widget!.requestQr.date!)} \nUntil : ${DateFormat('MMMM dd yyyy').format(widget!.requestQr.dateOut!)}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Icon(
                Icons.person,
                color: Colors.black54.withOpacity(.5),
                size: 35,
              ),
              Text(
                ': ${widget.requestQr.visitMembers != null ? widget.requestQr.visitMembers?.join(', ') : 'No members'}',
                // ^^^ This checks if visitMembers is not null, and then joins the list with ', ' if not null.
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Divider(
              color: Colors.black, indent: 20, endIndent: 20, height: 25),
          Center(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isLoadingAccept
                      ? null
                      : () async {
                    setState(() {
                      isLoadingAccept = true;
                    });
                    try {
                      await acceptQr(context, widget.requestQr.id);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$e'),
                        ),
                      );
                    } finally {
                      if (mounted) { // Ensure the widget is still in the tree.
                        setState(() {
                          isLoadingAccept = false;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    shape: CircleBorder(), // This makes the button circular.
                  ),
                  child: isLoadingAccept
                      ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                      : const Icon(Icons.check), // Using icon for a more symmetrical look.
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    shape: CircleBorder(), // This makes the button circular.
                  ),
                  child: const Icon(Icons.close), // Using icon for a more symmetrical look.
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
