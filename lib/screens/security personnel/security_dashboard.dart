import 'dart:async';
import 'package:communisyncmobile/screens/security%20personnel/security_notifications_page.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_search_if_mvo_on.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import '../../backend/api/personnel/checks_current_visitor.dart';
import '../../backend/api/personnel/checks_out_visitor.dart';
import '../../backend/model/models.dart';
import '../../backend/api/notification/notifications.dart' as notificationApi;
import 'package:communisyncmobile/backend/model/models.dart' as custom;
class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({Key? key}) : super(key: key);

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}

class _SecurityDashboardState extends State<SecurityDashboard> {
  late Future<List<Logbook>> _logbookFuture;
  bool _mounted = false; // Track the mounted state of the widget
  int notificationCount = 0; // Add a variable to hold the notification count

  @override
  void initState() {
    super.initState();
    _mounted = true; // Set to true when the widget is mounted
    _logbookFuture = _fetchLogbookData();
  }
  Future<void> loadNotificationCount() async {
    List<custom.Notification> notifications =
    await notificationApi.getNotifications();
    setState(() {
      notificationCount = notifications.length;
    });
  }
  @override
  void dispose() {
    _mounted = false; // Set to false when the widget is disposed
    super.dispose();
  }

  Future<void> _showDeleteConfirmationDialog(Logbook logbook, int id) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm out'),
          content:
              const Text('Are you sure you want to check out this visitor?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);

                try {
                  await outVisitor(logbook.id); // Perform deletion
                  if (_mounted) {
                    // Refresh data after deletion
                    _logbookFuture = _fetchLogbookData();

                    setState(() {
                    });
                  }
                } catch (e) {
                  // Handle errors
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {}
  }

  Future<List<Logbook>> _fetchLogbookData() async {
    try {
      return await checksCurrentVisitors();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    String host = dotenv.get("API_HOST", fallback: "");

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
                  child: Image.asset(
                    'assets/images/logo-white.png',
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, right: 10.0),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecurityNotificationsPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.notifications),
                      color: Colors.white,
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        top: 0, // Adjust the top value to your preference
                        right: 0, // Adjust the right value to your preference
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            '$notificationCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Current Visitors',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchIfMvoOn()),
                      );
                    },
                    child: Text('Add Manually'),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Logbook>>(
                  future: _logbookFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {

                          await _fetchLogbookData();

                          setState(() {
                            _logbookFuture = _fetchLogbookData();
                             loadNotificationCount();

                          });
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Logbook logbook = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              color: Colors.green,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green.shade800,
                                          Colors.green.shade400
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundImage: logbook.visitor !=
                                                    null
                                                ? NetworkImage(
                                                    '${host ?? ''}/storage/${logbook.visitor!.photo ?? ''}')
                                                : null,
                                            child:
                                                logbook.visitor?.photo == null
                                                    ? Icon(Icons.person,
                                                        size: 24,
                                                        color: Colors.white)
                                                    : null,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${logbook.visitor?.firstName ?? 'Manually Visited'} ${logbook.visitor?.lastName ?? ''}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Date: ${logbook.visitDate != null ? logbook.visitDate : 'N/A'}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Time: ${logbook.visitTime != null ? logbook.visitTime : 'N/A'}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            if (logbook.visitMembers != null)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Members:',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: logbook
                                                        .visitMembers!
                                                        .map((member) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 2.0),
                                                        child: Text(
                                                          member ?? 'N/A',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.outbond,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(
                                            logbook, logbook.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
