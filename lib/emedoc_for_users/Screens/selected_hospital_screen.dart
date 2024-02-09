import 'dart:math';

import 'package:emedoc/emedoc_for_hospital/repositories/auth_repository.dart';
import 'package:emedoc/utils/custom_button.dart';
import 'package:emedoc/ambulance/ambulance_repository.dart';
import 'package:emedoc/models/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedHospitalScreen extends StatefulWidget {
  const SelectedHospitalScreen({
    super.key,
    required this.hospital,
    required this.hospitalUid,
    required this.currentPosition,
  });
  final Hospitalinfo hospital;
  final String hospitalUid;
  final Position currentPosition;

  @override
  State<SelectedHospitalScreen> createState() => _SelectedHospitalScreenState();
}

class _SelectedHospitalScreenState extends State<SelectedHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital.name),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 197, 137, 157),
            ),
            child: Text(widget.hospital.address),
          ),
          CustomButton(
            text: 'Dial${widget.hospital.phoneNumber}',
            onPressed: () async {
              final call = 'tel:${widget.hospital.phoneNumber}';
              if (await canLaunchUrl(Uri.parse(call))) {
                await launchUrl((Uri.parse(call)));
              }
            },
            width: size.width * 0.5,
          ),
          CustomButton(
            text: 'Video Conferencing',
            onPressed: () {
              setState(() {
                requestVidCall(widget.hospitalUid, widget.currentPosition);
              });
            },
            width: size.width * 0.5,
          ),
          
          StreamBuilder(
            stream: checkAmbulanceStatus(widget.hospitalUid,auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                  onPressed: () {
                    if (snapshot.data == 1) {
                      requestAmbulance(
                          widget.hospitalUid, widget.currentPosition);
                    }
                  },
                  child: snapshot.data == 1
                      ? Text('Request Ambulance')
                      : snapshot.data == 2
                          ? Text('Request Sent')
                          : snapshot.data == 3
                              ? Text('Request Accepted')
                              : Text('Request Declined'));

              // Column(
              //   children: [
              //     snapshot.data
              //     Text(
              //       snapshot.data==1
              //           ? 'Request Ambulance'
              //           : 'Request has been sent',
              //       style: TextStyle(
              //           color: snapshot.data!
              //               ? const Color.fromARGB(255, 33, 243, 58)
              //               : Colors.blue),
              //     ),
              //   ],
              // );
            },
          ),
          // CustomButton(
          //   text: 'Share Medical Id',
          //   onPressed: () {},
          //   width: size.width * 0.5,
          // ),
        ],
      ),
    );
  }
}
