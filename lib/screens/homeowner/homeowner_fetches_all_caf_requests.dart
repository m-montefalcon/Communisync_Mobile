import 'package:communisyncmobile/backend/api/homeowner/CAF/fetch_requests.dart';
import 'package:communisyncmobile/backend/model/request_class.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_announcements_page.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_fetches_specific_caf_requests.dart';
import 'package:flutter/material.dart';

class AllRequestVSTwo extends StatefulWidget {
  const AllRequestVSTwo({super.key});

  @override
  State<AllRequestVSTwo> createState() => _AllRequestVSTwoState();
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
                              itemCount: requests.length,

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
                                            const Text('6/15/2023',
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




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
