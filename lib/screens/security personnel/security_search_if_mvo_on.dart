import 'package:flutter/material.dart';
import '../../backend/api/personnel/check_if_mvo_on.dart';
import '../../backend/model/models.dart';
import 'security_add_manual_logbook.dart';

class SearchIfMvoOn extends StatefulWidget {
  const SearchIfMvoOn({Key? key}) : super(key: key);

  @override
  State<SearchIfMvoOn> createState() => _SearchIfMvoOnState();
}

class _SearchIfMvoOnState extends State<SearchIfMvoOn> {
  final TextEditingController _searchController = TextEditingController();
  Homeowner? _searchResult;
  bool _isLoading = false;

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true; // Set the flag to true when search starts
    });

    String searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      Homeowner? result = await _fetchHomeowner(searchText);
      setState(() {
        _searchResult = result;
        _isLoading = false; // Set the flag to false when search is complete
      });
    } else {
      setState(() {
        _isLoading = false; // Set the flag to false if search text is empty
      });
    }
  }

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
                    _performSearch();
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
              child: _isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : _buildSearchResult(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    if (_searchResult != null) {
      Homeowner homeowner = _searchResult!;
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddManualLogbookPage(homeowner: homeowner),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade800, Colors.green.shade400],
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${homeowner.firstName} ${homeowner.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
  }
}
