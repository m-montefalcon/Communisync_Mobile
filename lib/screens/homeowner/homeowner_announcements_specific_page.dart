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
      appBar: AppBar(
        title: Text('ANNOUNCEMENTS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            '${host ?? ''}/storage/${widget.data.admin.photo}'),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.data.admin.firstName} ${widget.data.admin.lastName}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
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
                              Icon(
                                Icons.supervised_user_circle,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.data.title,
                    style: const TextStyle(
                      fontSize: 20.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjust the text color as needed
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              image: widget.data.photo != null
                                  ? DecorationImage(
                                image: NetworkImage(
                                  '${host ?? ''}/storage/${widget.data.photo ?? ''}',
                                ),
                                fit: BoxFit.contain,
                              )
                                  : null,
                              borderRadius: BorderRadius.circular(double.maxFinite),
                            ),
                            child: widget.data.photo != null
                                ? null
                                : Center(
                              child: Text(
                                'No complaint photo available',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                          color:
                              Colors.black, // Adjust the text color as needed
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
