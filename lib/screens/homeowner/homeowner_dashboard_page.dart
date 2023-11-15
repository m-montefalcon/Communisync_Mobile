import 'package:communisyncmobile/backend/api/homeowner/AF/fetch_announcements.dart';
import 'package:communisyncmobile/backend/api/homeowner/CAF/fetch_all_request_homeowner.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_page.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_specific_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_all_caf_requests.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_specific_caf_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  void initState() {
    super.initState();
    // Fetch data when the page is initialized
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
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Colors.purple.shade800,
                  //     Colors.purple.shade500,
                  //   ],
                  // ),
                  color: Colors.green.shade700
                ),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [

                  FutureBuilder<List<Announcement>>(
                    future: fetchAnnouncements(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Filter the announcements to only include those with pictures
                        List<Announcement> announcementsWithPictures = snapshot.data!.where((announcement) {
                          return announcement.photo != null && announcement.photo!.isNotEmpty;
                        }).toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              color: Colors.green,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(colors: [
                                    Colors.green.shade800,
                                    Colors.green.shade400,
                                  ]),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.tips_and_updates_rounded,
                                        size: 40, color: Colors.white),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Announcements',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 200,
                                      child: PageView.builder(
                                        itemCount: announcementsWithPictures.length >= 3 ? 3 : announcementsWithPictures.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SpecificAnnouncementPage(
                                                    data: announcementsWithPictures[index], // Pass the specific data
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 12,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(24),
                                              ),
                                              color: Colors.green,
                                              child: Container(
                                                height: 200,
                                                padding: const EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24),
                                                  gradient: LinearGradient(colors: [
                                                    Colors.green.shade800,
                                                    Colors.green.shade400,
                                                  ]),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    if (announcementsWithPictures[index].photo != null)
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: double.infinity,
                                                          width: 300,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(12.0),
                                                            child: Image.network(
                                                              '$host/storage/${announcementsWithPictures[index].photo!}',
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            )

                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Visitation Requests',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  FutureBuilder<List<Request>>(
                    future: getIdFromSharedPreferencesAndFetchData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // Handle the case where there are no requests.
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                'No requests available.'
                            ),
                          ),
                        );
                      } else {
                        final List<Request> requests = snapshot.data!;
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: requests.isNotEmpty ? 1 : 0, // Display one item if there are requests
                              itemBuilder: (context, index) {
                                final Request request = requests[index];
                                return Stack(
                                  children: [
                                    Card(
                                      margin: const EdgeInsets.all(10),
                                      elevation: 12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      color: Colors.green,
                                      child: Container(
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
                                            // Circular Photo on the most left
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: CircleAvatar(
                                                radius: 24,
                                                backgroundImage: NetworkImage(
                                                  '${host ?? ''}/storage/${request.visitor.photo}',
                                                ),
                                              ),
                                            ),


                                            const SizedBox(width: 10),

                                            // Padding to the right of the circular photo
                                            const SizedBox(width: 10),

                                            // Visitor's name at the top center
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Visitor's name at the top
                                                Text(
                                                  '${request.visitor.firstName} ${request.visitor.lastName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold, // Adjust as needed
                                                  ),
                                                ),

                                                const SizedBox(height: 10),

                                                // Date at the bottom center
                                                Text(
                                                  ' ${request.date} ',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),


                                      ),
                                    ),
                                    Positioned(
                                      right: 40,
                                      bottom: 30,
                                      child: GestureDetector(
                                        onTap: () {
                                          Request tappedRequest = requests[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SpecificRequestVSTwo(
                                                request: tappedRequest,
                                              ),
                                            ),
                                          );
                                          print('clicked');
                                        },
                                        child: Icon(
                                          Icons.navigate_next,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            // Container to hold the "See More" button
                            Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    print('see more clicked');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllRequestVSTwo(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'See More',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );


                      }
                    },
                  ),



                  const SizedBox(height: 10),
                  Row(
                    children: const [
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
                    ],
                  ),
                  Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.green,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.green.shade800,
                              Colors.green.shade400
                            ]),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Pet Wastes Complaint',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Add some spacing between the texts
                                      Text(
                                        'Pending',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(width: 18),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 40,
                        bottom: 30,
                        child: Icon(
                          Icons.navigate_next,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.green,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.green.shade800,
                              Colors.green.shade400
                            ]),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Successfully paid',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Date of payment:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Add some spacing between the texts
                                      Text(
                                        '04/23/2023',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(width: 18),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 40,
                        bottom: 30,
                        child: Icon(
                          Icons.navigate_next,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
