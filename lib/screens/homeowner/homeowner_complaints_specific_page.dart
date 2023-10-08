import 'package:communisyncmobile/backend/model/models.dart';
import 'package:communisyncmobile/constants/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpecificComplaintPage extends StatefulWidget {
  final Complaint data;

  const SpecificComplaintPage({super.key, required this.data});

  @override
  State<SpecificComplaintPage> createState() => _SpecificComplaintPageState();
}

class _SpecificComplaintPageState extends State<SpecificComplaintPage> {
  @override
  Widget build(BuildContext context) {
    String host = dotenv.get("API_HOST", fallback: "");

    return  Scaffold(
        body: NestedScrollView(

          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled)=>[
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
          body: Column(

            children: [
              SizedBox(height: 20),
              widget.data.admin?.photo != null
                  ? Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${host ?? ''}/storage/${widget.data.admin?.photo}'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Text('No profile available'),
              Center(
                child: Text('${widget.data.admin?.firstName}'),
              ),
              Center(
                child: Text('${widget.data.admin?.lastName}'),
              ),
              Center(
                child: Text(widget.data.title),
              ),
              Center(
                child: Text(widget.data.description),
              ),
              SizedBox(height: 20),
              widget.data.photo != null
                  ? Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${host ?? ''}/storage/${widget.data.photo}'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Text('No complaint photo available'),
              SizedBox(height: 20),
              if (widget.data.updates != null)
                Column(
                  children: widget.data.updates!.map((update) {
                    return Column(
                      children: [
                        if (update.update != null && update.resolution == null) // Add condition to check if there is no resolution
                          Text('Update: ${update.update?.join(", ")}'),
                        if (update.resolution != null)
                          Text('Resolution: ${update.resolution}'),
                        if (update.date != null)
                          Text('Date: ${update.date}'),
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ),




            ],
          ),

        )
    );
  }
}
