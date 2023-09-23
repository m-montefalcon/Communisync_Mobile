import 'package:communisyncmobile/backend/api/homeowner/CAF/fetch_all_request_homeowner.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_page.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_all_caf_requests.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_specific_caf_requests.dart';
import 'package:flutter/material.dart';
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
                  color: Colors.purple.shade700
                ),
                child: const Center(
                  child: Text(
                    'CommuniSync',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
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
                  const SizedBox(height: 5),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.purple,
                    child: Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(colors: [
                          Colors.purple.shade800,
                          Colors.purple.shade400
                        ]),
                      ),
                      child: GestureDetector(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tips_and_updates_rounded,
                                size: 50, color: Colors.white),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Announcements',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .fontSize)),
                                Text('Swipe to see more...',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .fontSize))
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AnnouncementPage()));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                          child: Text('No requests available.'),
                        );
                      } else {
                        final List<Request> requests = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Requests',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                     print('see more clicked');
                                     Navigator.push(context,
                                         MaterialPageRoute(
                                             builder: (context)=>AllRequestVSTwo()
                                         )
                                     );
                                    },
                                    child: Text(
                                      'See More',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2, // Display only two items
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
                                      color: Colors.purple,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          gradient: LinearGradient(colors: [
                                            Colors.purple.shade800,
                                            Colors.purple.shade400
                                          ]),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  <Widget>[
                                                Text(
                                                  'Request ID: ${request.id.toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'Visitor ID: ${request.visitorId}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 18),
                                             Text(
                                                'testing: ${request.date}',
                                                style: TextStyle(color: Colors.white)),
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
                                            MaterialPageRoute(builder: (context) => SpecificRequestVSTwo(request: tappedRequest)),
                                          );
                                          print('clicked');
                                        },
                                        child:  Icon(
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
                        color: Colors.purple,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade400
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
                        color: Colors.purple,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade400
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
