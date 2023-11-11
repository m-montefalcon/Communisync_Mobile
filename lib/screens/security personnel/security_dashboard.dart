import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';

class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({Key? key}) : super(key: key);

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}
final _formKey = GlobalKey<FormState>();
final TextEditingController _searchController = TextEditingController();
class _SecurityDashboardState extends State<SecurityDashboard> {
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
                decoration: BoxDecoration(color: Colors.green.shade700),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                key: _formKey,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.menu), onPressed: () {}),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        setState(() {
                          // _homeownersFuture =
                          //     getCafSearchRequestApi(_searchController.text);
                        });
                      }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              const SizedBox(height: 16.0),
              // FutureBuilder<>(
              //   future: ,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // While data is loading, display a loading indicator
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       // If there's an error, display an error message
              //       return Text('Error: ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       // If data is available, display it using a ListView
              //       final data = snapshot.data;
              //       return Expanded(
              //         child: ListView.builder(
              //           itemCount: data!.length,
              //           itemBuilder: (context, index) {
              //             final homeowner = data[index];
              //             return ListTile(
              //               leading: const Icon(
              //                 Icons.face,
              //                 size: 40,
              //               ),
              //               subtitle: Text(
              //                 homeowner.userName,
              //                 style: TextStyle(
              //                   color: Colors.black54.withOpacity(.3),
              //                 ),
              //               ),
              //               title: Text(
              //                 '${homeowner.firstName} ${homeowner.lastName}',
              //                 style: const TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 20,
              //                 ),
              //               ),
              //               onTap: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             TapSpecificName(homeowner: homeowner)
              //                     )
              //                 );
              //               },
              //               // Add more fields as needed
              //             );
              //           },
              //         ),
              //       );
              //     } else {
              //       // If there's no data, display a message
              //       return const Text('No data available');
              //     }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
