import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpecificComplaintPage extends StatefulWidget {
  final Complaint data;

  const SpecificComplaintPage({super.key, required this.data});

  @override
  State<SpecificComplaintPage> createState() => _SpecificComplaintPageState();
}

class _SpecificComplaintPageState extends State<SpecificComplaintPage> {
  @override
  Widget build(BuildContext context) {
    String host = dotenv.get("API_HOST", fallback: "");

    return Scaffold(
      appBar: AppBar(
        title: Text('SPECIFIC COMPLAINT'),
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
                        backgroundImage: widget.data.admin?.photo != null
                            ? NetworkImage(
                                '${host ?? ''}/storage/${widget.data.admin?.photo}')
                            : null,
                        child: widget.data.admin?.photo == null
                            ? Icon(Icons.person)
                            : null,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.data.admin?.firstName ?? ''} ${widget.data.admin?.lastName ?? 'Pending'}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Admin',
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
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            width: 300,
                            height: 250,
                            decoration: BoxDecoration(
                              image: widget.data.photo != null
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        '${host ?? ''}/storage/${widget.data.photo ?? ''}',
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(12),
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
                          SizedBox(height: 5),
                          Text(
                            '${widget.data.title ?? ''}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '"${widget.data.description ?? ''}"',
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      (widget.data.updates ?? []).map((update) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Updates: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        if (update?.update != null &&
                                            update?.resolution == null)
                                          Text(
                                              'Update: ${update?.update?.join(", ") ?? ''}'),
                                        if (update?.resolution != null)
                                          Text(
                                              'Resolution: ${update?.resolution ?? ''}'),
                                        if (update?.date != null)
                                          Text('Date: ${update?.date ?? ''}'),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1.0, color: Colors.green),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'GOT IT',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
