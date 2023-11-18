import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/visitor/visitor_ontap_access_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../backend/api/visitor/fetch_all_validated_request.dart';

class VisitorDashboardPage extends StatefulWidget {
  const VisitorDashboardPage({Key? key}) : super(key: key);

  @override
  State<VisitorDashboardPage> createState() => _VisitorDashboardPageState();
}

class _VisitorDashboardPageState extends State<VisitorDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
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
          ),
          FutureBuilder<List<FetchAllQr>>(
            future: fetchAllRequestApi(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No data available'),
                  ),
                );
              } else {
                final fetchAllData = snapshot.data; // Retrieve the fetched data

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final item = fetchAllData?[index];
                      return Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        // Your existing ListTile
                                        ListTile(
                                          title: Text(
                                            'ID: ${item?.id}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Destination Person: ${item?.destinationPerson ?? 'None'}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Homeowner: ${item?.homeowner != null ? '${item?.homeowner!.firstName ?? 'None'} ${item?.homeowner!.lastName ?? 'None'}' : 'None'}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Admin: ${item?.admin != null ? '${item?.admin!.firstName ?? 'None'} ${item?.admin!.lastName ?? 'None'}' : 'None'}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              const Text(
                                                'Visit Members: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '${item?.visitMembers != null && item!.visitMembers!.isNotEmpty ? item!.visitMembers!.join(', ').replaceAll('[', '').replaceAll(']', '').replaceAll('"', '') : 'None'}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 10, // Adjust the position as needed
                                          top: 10,  // Adjust the position as needed
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 35,
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                        Positioned(
                                          right: 10, // Adjust the position as needed
                                          bottom: 10,  // Adjust the position as needed
                                          child: Icon(
                                            Icons.check_circle,
                                            size: 35,
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.0),
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => DisplayQrCode(svgData: item?.qrCode ?? '')
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: fetchAllData?.length ?? 0,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
