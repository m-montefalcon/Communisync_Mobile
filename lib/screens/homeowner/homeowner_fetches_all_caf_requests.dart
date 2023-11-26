import 'package:communisyncmobile/backend/api/homeowner/CAF/fetch_all_request_homeowner.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_specific_caf_requests.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllRequestVSTwo extends StatefulWidget {
  const AllRequestVSTwo({super.key});

  @override
  State<AllRequestVSTwo> createState() => _AllRequestVSTwoState();
}
String formatTimestamp(String dateTimeString) {
  DateTime timestamp = DateTime.parse(dateTimeString);
  final formatter = DateFormat('h:mm a MMM d, yyyy');
  return '${formatter.format(timestamp)}';
}

class _AllRequestVSTwoState extends State<AllRequestVSTwo> {
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
                    color: Colors.green.shade700
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

                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: requests.length,
                              itemBuilder: (context, index) {
                                final Request request = requests[index];
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                          Request tappedRequest = requests[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SpecificRequestVSTwo(request: tappedRequest)),
                                          );
                                          print('clicked');
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

                                                  // Date at the bottom center
                                                  Text(
                                                    formatTimestamp('${request.date}'),
                                                    style: TextStyle(
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
                                    Positioned(
                                      right: 40,
                                      bottom: 38,
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




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
