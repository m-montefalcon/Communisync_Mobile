import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpecificAnnouncementPage extends StatefulWidget {
  final Announcement data;

  const SpecificAnnouncementPage({super.key, required this.data});

  @override
  State<SpecificAnnouncementPage> createState() =>
      _SpecificAnnouncementPageState();
}

class _SpecificAnnouncementPageState extends State<SpecificAnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    String host = dotenv.get("API_HOST", fallback: "");

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 325,
            width: double.infinity,
            child: Stack(
              children: [
                // Your photo container or image
                widget.data.photo != null
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '$host/storage/${widget.data.photo}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Center(child: Text('No announcement photo available')),

                // Gradient effect for the title and description
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0, 1],
                        colors: [
                          Colors.white.withOpacity(1),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 20),
          // widget.data.admin.photo != null
          //     ? Container(
          //   width: 300,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage('${host ?? ''}/storage/${widget.data.admin.photo}'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // )
          //     : Text('No announcement photo available'),
          // Center(
          //   child: Text(widget.data.admin.firstName),
          // ),
          // Center(
          //   child: Text(widget.data.admin.lastName),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.title,
                    style: const TextStyle(
                      fontSize: 30.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjust the text color as needed
                    ),
                  ),
                  const SizedBox(
                      height:
                          8.0), // Adjust the spacing between title and description
                  Text(
                    widget.data.description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 18.0, // Adjust the font size as needed
                      color: Colors.black, // Adjust the text color as needed
                    ),
                  ),

                  const Spacer(),

                  const Divider(height: 1.0, color: Colors.black),

                  const SizedBox(height: 16.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'GOT IT',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
