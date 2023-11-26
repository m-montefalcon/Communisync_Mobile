import 'package:communisyncmobile/backend/api/homeowner/AF/fetch_announcements.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_specific_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
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
        body: RefreshIndicator(
          onRefresh: () async {
            // Implement your refresh logic here
            // For example, you can setState and re-fetch data
            setState(() {
              // Update state variables or re-fetch data
            });
          },
          child: Column(
            children: [
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
              ),
              FutureBuilder<List<Announcement>>(
                future: fetchAnnouncements(),
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
                    final List<Announcement> announcementData = snapshot.data!;

                    return Expanded(
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
                                          SpecificAnnouncementPage(data: data),
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
                                        // Positioned(
                                        //   bottom: 0,
                                        //   right: 0,
                                        //   child: Text(
                                        //     formatTimestamp(data.date),
                                        //     style: TextStyle(
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 24,
                                              backgroundImage: NetworkImage(
                                                  '${host ?? ''}/storage/${data.admin.photo}'),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${data.admin.firstName} ${data.admin.lastName}',
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Admin',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Text(
                                                    'Title: ${data.title}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    formatTimestamp(data.date),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   'Details:',
                                                  //   style: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 15,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //   truncateDescription(
                                                  //       data.description),
                                                  //   style: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 15,
                                                  //   ),
                                                  // ),
                                                  // SizedBox(height: 25),
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
