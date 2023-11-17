import 'package:communisyncmobile/screens/security%20personnel/security_add_manual_logbook.dart';
import 'package:flutter/material.dart';
import '../../backend/api/personnel/check_if_mvo_on.dart';
import '../../backend/model/models.dart';

class SearchIfMvoOn extends StatefulWidget {
  const SearchIfMvoOn({Key? key}) : super(key: key);

  @override
  State<SearchIfMvoOn> createState() => _SearchIfMvoOnState();
}

class _SearchIfMvoOnState extends State<SearchIfMvoOn> {
  final TextEditingController _searchController = TextEditingController();

  Future<Homeowner?> _fetchHomeowner(String fullName) async {
    try {
      // Simulating a delay. Replace this with actual data fetching logic.
      await Future.delayed(Duration(seconds: 2));
      return checksIfMvoOn(fullName);
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Manually Logbook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Handle menu icon press
                    print('Menu icon pressed');
                  },
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String searchText = _searchController.text;
                    setState(() {
                      // Trigger a rebuild with the new search text
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<Homeowner?>(
                future: _fetchHomeowner(_searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(''),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    Homeowner homeowner = snapshot.data!;
                    return ListView.builder(
                      itemCount: 1, // Display only one item
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Add the navigation logic here
                            // For example, you can use Navigator.push to navigate to another screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddManualLogbookPage(homeowner: homeowner,),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Adjust the border radius
                            ),
                            color: Colors.green,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, // Adjust the horizontal padding
                                vertical: 16.0, // Adjust the vertical padding
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12), // Adjust the border radius
                                gradient: LinearGradient(
                                  colors: [Colors.green.shade800, Colors.green.shade400],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Visitor's name at the top
                                      Text(
                                        '${homeowner.firstName} ${homeowner.lastName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18, // Adjust the font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                  } else {
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
