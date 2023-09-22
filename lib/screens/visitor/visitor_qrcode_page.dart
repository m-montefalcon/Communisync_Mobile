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
                decoration: BoxDecoration(color: Colors.purple.shade700),
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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search....',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}