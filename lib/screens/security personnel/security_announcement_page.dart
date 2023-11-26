import 'package:flutter/material.dart';
import 'package:communisyncmobile/backend/api/personnel/fetch_announcement_sp.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/security%20personnel/security_announcement_specific_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class SecurityAnnouncementPage extends StatefulWidget {
  const SecurityAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<SecurityAnnouncementPage> createState() =>
      _SecurityAnnouncementPageState();
}

class _SecurityAnnouncementPageState extends State<SecurityAnnouncementPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh() async {
    // Perform your refresh logic here
    await fetchAnnouncementsAsSp();
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

    String formatTimestamp(String dateTimeString) {
      DateTime timestamp = DateTime.parse(dateTimeString);
      final formatter = DateFormat('MMM d, yyyy');
      return 'Date: ${formatter.format(timestamp)}';
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
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                ),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            const SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Announcements',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Announcement>>(
              future: fetchAnnouncementsAsSp(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No requests available.'),
                  );
                } else {
                  final List<Announcement> announcementData = snapshot.data!;

                  return Expanded(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: announcementData.length,
                        itemBuilder: (context, index) {
                          final Announcement data = announcementData[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SpecificAnnouncementPageAsSp(data: data),
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
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Text(
                                            formatTimestamp(data.date),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 24,
                                              backgroundImage: NetworkImage(
                                                  '$host/storage/${data.admin.photo}'),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${data.admin.firstName} ${data.admin.lastName}',
                                                    style: const TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Admin',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Text(
                                                    'Title: ${data.title}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  const Text(
                                                    'Details:',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    truncateDescription(
                                                        data.description),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 25),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
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
