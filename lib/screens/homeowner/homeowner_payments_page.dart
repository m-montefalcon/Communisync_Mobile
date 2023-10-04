import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';

class PaymentsHistory extends StatefulWidget {
  const PaymentsHistory({Key? key}) : super(key: key);

  @override
  State<PaymentsHistory> createState() => _PaymentsHistoryState();
}

class _PaymentsHistoryState extends State<PaymentsHistory> {
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
                            'Payment History',
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
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Successfully paid',
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
                                          'Date of payment:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                            5), // Add some spacing between the texts
                                        Text(
                                          '04/23/2023',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Transaction number:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '0034834764',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Ammount:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '2,000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Received by:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Management',
                                          style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                  ],
                                ),
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
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Successfully paid',
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
                                          'Date of payment:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                            5), // Add some spacing between the texts
                                        Text(
                                          '03/22/2023',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Transaction number:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '00343847535',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Ammount:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '2,500',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Received by:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Management',
                                          style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                  ],
                                ),
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
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Successfully paid',
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
                                          'Date of payment:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                            5), // Add some spacing between the texts
                                        Text(
                                          '02/19/2023',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Transaction number:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '0034886457',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Ammount:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '2,350',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          'Received by:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Management',
                                          style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 15,
                                          ),
                                        ), // Add some spacing between the texts
                                      ],
                                    ),
                                  ],
                                ),
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
