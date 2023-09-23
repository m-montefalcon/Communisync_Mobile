import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';

class VisitorQrCodePage extends StatefulWidget {
  const VisitorQrCodePage({Key? key}) : super(key: key);

  @override
  State<VisitorQrCodePage> createState() => _VisitorQrCodePageState();
}

class _VisitorQrCodePageState extends State<VisitorQrCodePage> {
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
        body: Column(
          children: const [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Icon(Icons.construction, size: 200, color: Colors.purple),
            ),
            Text('UNDER CONSTRUCTION',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 25))
          ],
        ),
      ),


    );
  }
}
