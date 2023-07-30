import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';

class VisitorDashboardPage extends StatefulWidget {
  const VisitorDashboardPage({Key? key}) : super(key: key);

  @override
  State<VisitorDashboardPage> createState() => _VisitorDashboardPageState();
}

class _VisitorDashboardPageState extends State<VisitorDashboardPage> {
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
                  const SizedBox(height: 5),
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
                                children: const <Widget>[
                                  Text(
                                    'Visitor',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John de Bisita',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639833746512',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Date of visit:',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '06/15/2023',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'at 2:03 pm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 25,
                        bottom: 40,
                        child: Icon(
                          Icons.pending,
                          size: 35,
                          color: Colors.white,
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
                                children: const <Widget>[
                                  Text(
                                    'Visitor',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John de Bisita',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639833746512',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Date of visit:',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '07/18/2023',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'at 4:33 pm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 25,
                        bottom: 40,
                        child: Icon(
                          Icons.check_circle,
                          size: 35,
                          color: Colors.greenAccent,
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
                                children: const <Widget>[
                                  Text(
                                    'Visitor',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John de Bisita',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639833746512',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Date of visit:',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '08/23/2023',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'at 8:22 am',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 25,
                        bottom: 40,
                        child: Icon(
                          Icons.check_circle,
                          size: 35,
                          color: Colors.greenAccent,
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
                                children: const <Widget>[
                                  Text(
                                    'Visitor',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John de Bisita',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639833746512',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Date of visit:',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '09/13/2023',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'at 12:14 pm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 25,
                        bottom: 40,
                        child: Icon(
                          Icons.check_circle,
                          size: 35,
                          color: Colors.greenAccent,
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
