import 'package:flutter/material.dart';

import '../../backend/api/notification/mark_as_read.dart';
import '../../backend/api/notification/mark_as_read.dart';
import '../../backend/api/notification/notifications.dart';
import '../../constants/custom_clipper.dart';
import 'package:communisyncmobile/backend/model/models.dart' as custom;
class VisitorNotificationsPage extends StatefulWidget {
  const VisitorNotificationsPage({Key? key}) : super(key: key);

  @override
  State<VisitorNotificationsPage> createState() => _VisitorNotificationsPageState();
}

class _VisitorNotificationsPageState extends State<VisitorNotificationsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshNotifications() async {
    try {

      // Simulating a delay before fetching notifications
      await Future.delayed(Duration(seconds: 2));

      // Refresh the data by calling getNotifications again
      setState(() {});
    } catch (e) {
      print('Error refreshing notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshNotifications,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 150,
              flexibleSpace: ClipPath(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade800, Colors.green.shade400],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'CommuniSync',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await markAsRead(context);
                            _refreshNotifications();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Mark All as Read'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<custom.Notification>>(
              future: getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('No notifications found.'),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        custom.Notification notification =
                        snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.green,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  notification.body,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Date and Time: ${notification.date}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
