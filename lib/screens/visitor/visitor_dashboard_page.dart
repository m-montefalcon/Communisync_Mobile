import 'package:communisyncmobile/backend/api/visitor/fetch_all_validated_request.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Import your model class and fetchAllRequestApi function here.

class VisitorDashboardPage extends StatefulWidget {
  const VisitorDashboardPage({Key? key}) : super(key: key);

  @override
  State<VisitorDashboardPage> createState() => _VisitorDashboardPageState();
}

class _VisitorDashboardPageState extends State<VisitorDashboardPage> {
  List<FetchAllQr> fetchAllData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final data = await fetchAllRequestApi(context);

      setState(() {
        fetchAllData = data;
      });
    } catch (e) {
      // Handle errors here.
      print('Error fetching data: $e');
    }
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
        ],
          body: FutureBuilder<List<FetchAllQr>>(
            future: fetchAllRequestApi(context),
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
                return Center(
                  child: Text('No data available'),
                );
              } else {
                final fetchAllData = snapshot.data; // Retrieve the fetched data

                return SingleChildScrollView(
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            color: Colors.purple,
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

                          // Display the ListTiles with IDs.
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: fetchAllData?.length,
                            itemBuilder: (context, index) {
                              final item = fetchAllData?[index];
                              return ListTile(
                                title: Text('ID: ${item?.id}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Destination Person: ${item?.destinationPerson ?? 'None'}'),
                                    Text('Homeowner: ${item?.homeowner != null ? '${item?.homeowner!.firstName ?? 'None'} ${item?.homeowner!.lastName ?? 'None'}' : 'None'}'),
                                    Text('Admin: ${item?.admin != null ? '${item?.admin!.firstName ?? 'None'} ${item?.admin!.lastName ?? 'None'}' : 'None'}'),
                                    Text('Visit Members: ${item?.visitMembers?.join(', ') ?? 'None'}'),
                                    SvgPicture.string(
                                      item?.qrCode ?? '',  // Assuming item?.qrCode contains the SVG data
                                      width: 200,          // Set the desired width
                                      height: 200,         // Set the desired height
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          )

      ),
    );
  }
}
