import 'package:communisyncmobile/backend/model/models.dart';
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
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.purple.shade700,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                return SliverFillRemaining(
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
                return SliverFillRemaining(
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
                      return Column(
                        children: [
                          ListTile(
                            title: Text('ID: ${item?.id}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Destination Person: ${item?.destinationPerson ?? 'None'}'),
                                Text('Homeowner: ${item?.homeowner != null ? '${item?.homeowner!.firstName ?? 'None'} ${item?.homeowner!.lastName ?? 'None'}' : 'None'}'),
                                Text('Admin: ${item?.admin != null ? '${item?.admin!.firstName ?? 'None'} ${item?.admin!.lastName ?? 'None'}' : 'None'}'),
                                Text('Visit Members: ${item?.visitMembers?.join(', ') ?? 'None'}'),
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: SvgPicture.string(
                                    item?.qrCode ?? '', // Assuming item?.qrCode contains the SVG data
                                    width: 200, // Set the desired width
                                    height: 200, // Set the desired height
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
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
