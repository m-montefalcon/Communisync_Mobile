import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:core';

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

    String formatTimestamp(String dateTimeString) {
      DateTime timestamp = DateTime.parse(dateTimeString);
      final formatter = DateFormat('MMM d, yyyy');
      return 'Date: ${formatter.format(timestamp)}';
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 325,
              width: double.infinity,
              child: Stack(
                children: [
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('${host ?? ''}/storage/${widget.data.admin.photo}'),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.data.admin.firstName} ${widget.data.admin.lastName}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                formatTimestamp(widget.data.date),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.supervised_user_circle,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.data.title,
                    style: const TextStyle(
                      fontSize: 30.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Adjust the text color as needed
                    ),
                  ),
                  const SizedBox(
                      height:
                          8.0), // Adjust the spacing between title and description
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 222,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.data.description,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18.0, // Adjust the font size as needed
                          color: Colors.black, // Adjust the text color as needed
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 9.0),

                  const Divider(height: 1.0, color: Colors.green),

                  const SizedBox(height: 9.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.green,
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
          ],
        ),
      ),
    );
  }
}
