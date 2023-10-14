import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../backend/api/homeowner/PR/fetch_payment_records.dart';

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
        body: FutureBuilder<List<PaymentRecords>>(
          future: fetchRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('No payment records found.'),
              );
            } else {
              final paymentRecords = snapshot.data!;
              final message = paymentRecords.isNotEmpty ? paymentRecords[0].message : '';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left

                children: [


                  Text(
                    'PAYMENT HISTORY',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: paymentRecords.length,
                      itemBuilder: (context, index) {
                        final PaymentRecords records = paymentRecords[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          color: Colors.purple,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 20.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade800,
                                  Colors.purple.shade400,
                                ],
                              ),
                            ),
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
                                  children: [
                                    Text(
                                      'Date of payment:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${records.paymentDate}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Transaction number:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${records.transactionNumber}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Amount:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${records.paymentAmount}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Notes:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      records.notes ?? 'None', // Use null check here
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    )

                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Received by:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${records.admin?.firstName} ${records.admin?.lastName} ',
                                      style: TextStyle(
                                        color: Colors.greenAccent,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),





      ),

    );

  }


}
