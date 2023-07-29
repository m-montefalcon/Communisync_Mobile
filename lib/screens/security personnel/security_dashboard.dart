import 'package:communisyncmobile/screens/homeowner/custom_clipper.dart';
import 'package:flutter/material.dart';

class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({Key? key}) : super(key: key);

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}

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
                            'Visits History',
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
                                    'Princess Kate',
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
                                    'Homeowner',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639738455098',
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
                        right: 185,
                        bottom: 40,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 35,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const Positioned(
                        right: 20,
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
                                    'Princess Kate',
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
                                    'Homeowner',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639738455098',
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
                        right: 185,
                        bottom: 40,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 35,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const Positioned(
                        right: 20,
                        bottom: 40,
                        child: Icon(
                          Icons.block,
                          size: 35,
                          color: Colors.red,
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
                                    'Princess Kate',
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
                                    'Homeowner',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639738455098',
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
                        right: 185,
                        bottom: 40,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 35,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const Positioned(
                        right: 20,
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
                                    'Princess Kate',
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
                                    'Homeowner',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+639738455098',
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
                        right: 185,
                        bottom: 40,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 35,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const Positioned(
                        right: 20,
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
