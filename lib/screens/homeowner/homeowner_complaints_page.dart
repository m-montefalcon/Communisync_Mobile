import 'package:communisyncmobile/backend/api/homeowner/CF/fetch_complaints.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_add_complaint_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_complaints_specific_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  Future<List<Complaint>>? _complaintsFuture;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _complaintsFuture = fetchComplaints();
  }

  String getStatusString(String? status) {
    if (status == null) {
      return 'Unknown Status';
    }

    switch (int.tryParse(status)) {
      case 1:
        return 'Submitted';
      case 2:
        return 'Opened';
      case 3:
        return 'Resolved';
      default:
        return 'Unknown Status';
    }
  }

  @override
  Widget build(BuildContext context) {
    String host = dotenv.get("API_HOST", fallback: "");

    String truncateDescription(String description) {
      List<String> words = description.split(' ');
      if (words.length > 4) {
        return '${words.sublist(0, 4).join(' ')}...';
      } else {
        return description;
      }
    }

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 110,
            elevation: 0.0,
            flexibleSpace: ClipPath(
              clipper: AppBarCustomClipper(),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.green.shade700),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Complaints',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddComplaintsPage(),
                              ),
                            );
                          },
                          child: Text('Add Complaint'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    setState(() {
                      _complaintsFuture = fetchComplaints();
                    });
                  },
                  child: FutureBuilder<List<Complaint>>(
                    future: _complaintsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Text('No requests available.'),
                        );
                      } else {
                        List<Complaint> complaints = snapshot.data!;

                        return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: complaints.length,
                          itemBuilder: (context, index) {
                            Complaint complaint = complaints[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SpecificComplaintPage(data: complaint),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                elevation: 12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                color: Colors.green,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(colors: [
                                      Colors.green.shade800,
                                      Colors.green.shade400
                                    ]),
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundImage:
                                            complaint.admin?.photo != null
                                                ? NetworkImage(
                                                '${host ?? ''}/storage/${complaint.admin?.photo ?? ''}')
                                            as ImageProvider<Object>?
                                                : null,
                                            child: complaint.admin == null
                                                ? Icon(Icons.person)
                                                : null,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  complaint.admin != null
                                                      ? 'Reviewed by: '
                                                      : 'Pending',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${complaint.admin?.firstName ?? ''} ${complaint.admin?.lastName ?? ''}',
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 7),
                                                Text(
                                                  'Title: ${complaint.title}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'Status: ${getStatusString(complaint.status)}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
