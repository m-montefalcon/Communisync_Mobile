import 'package:communisyncmobile/backend/api/homeowner/PR/fetch_payment_records.dart';
import 'package:communisyncmobile/backend/api/homeowner/PR/view_records_as_pdf.dart';
import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:communisyncmobile/screens/homeowner/homeowner_payment_pdfviewer_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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
                  color: Colors.green.shade700,
                ),
                child: Center(
                  child: Image.asset('assets/images/logo-white.png',
                      width: 160, height: 160),
                ),
              ),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            // Implement your refresh logic here
            // For example, you can setState and re-fetch data
            setState(() {
              // Update state variables or re-fetch data
            });
          },
          child: FutureBuilder<List<PaymentRecords>>(
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
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Calculate the number of months between January 2023 and the current date
                final currentDate = DateTime.now();
                final january2023 = DateTime(2023, 0);
                final monthsBehind =
                    (currentDate.year - january2023.year) * 12 +
                        (currentDate.month - january2023.month);

                // Calculate the next payment date (current month)
                final nextPaymentDate =
                    DateTime(currentDate.year, currentDate.month);

                // Format the message
                final message =
                    'No payment records found. \nYou are behind by $monthsBehind months. \n Next payment is for ${DateFormat('MMMM yyyy').format(nextPaymentDate)}';

                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              } else {
                final paymentRecords = snapshot.data!;
                final message =
                    paymentRecords.isNotEmpty ? paymentRecords[0].message : '';

                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'PAYMENT HISTORY',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    fetchPdfRecord(context);
                                  },
                                  child: Text('View PDF'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              message.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: paymentRecords.length,
                          itemBuilder: (context, index) {
                            final PaymentRecords records =
                                paymentRecords[index];
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              color: Colors.green,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green.shade800,
                                      Colors.green.shade400,
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
                                          records.notes ??
                                              'None', // Use null check here
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
                                    ), // ... Other payment record details
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
