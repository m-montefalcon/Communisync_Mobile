import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
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
                    color: Colors.purple.shade700),
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
                              horizontal: 15.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade400
                            ]),
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.update,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text('6/15/2023',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 10),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Pet Wastes Complaint',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
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
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Text(
                                              'Details:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    5), // Add some spacing between the texts
                                          ],
                                        ),
                                        const Text(
                                          'I hope this message finds you well. '
                                          'I am writing to address a concerning '
                                          'issue that has been observed in our '
                                          'beloved subdivision recently.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                              horizontal: 15.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade400
                            ]),
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.update,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text('1/18/2023',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 10),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Saba kaayo videoke!!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
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
                                              'Solved',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Text(
                                              'Details:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    5), // Add some spacing between the texts
                                          ],
                                        ),
                                        const Text(
                                          'I hope this message finds you well. '
                                          'I am writing to address a concerning '
                                          'issue that has been observed in our '
                                          'beloved subdivision recently.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                              horizontal: 15.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade400
                            ]),
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.update,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text('3/23/2023',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 10),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Naay pang milktea, di pautang!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
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
                                              'Solved',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: const [
                                            Text(
                                              'Details:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    5), // Add some spacing between the texts
                                          ],
                                        ),
                                        const Text(
                                          'I hope this message finds you well. '
                                          'I am writing to address a concerning '
                                          'issue that has been observed in our '
                                          'beloved subdivision recently.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
