import 'package:emedoc/emedoc_for_hospital/repositories/auth_repository.dart';
import 'package:emedoc/utils/custom_button.dart';
import 'package:emedoc/ambulance/ambulance_repository.dart';
import 'package:emedoc/models/hospital_model.dart';
import 'package:emedoc/utils/shortcut.dart';
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
  String detailsUid = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital.name),
      ),
      body: Column(
        children: [
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
          SizedBox(height: size.height * 0.05),
          CustomButton(
            text: 'Video Conferencing',
            onPressed: () {
              setState(() {
                requestVidCall(widget.hospitalUid, widget.currentPosition);
              });
            },
            width: size.width * 0.5,
          ),
          SizedBox(height: size.height * 0.05),
          StreamBuilder(
            stream:
                checkAmbulanceStatus(widget.hospitalUid, auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return CustomButton(
                width: size.width * 0.5,
                onPressed: () {
                  if (snapshot.data == 1) {
                    requestAmbulance(
                        widget.hospitalUid, widget.currentPosition);
                  }
                },
                text: snapshot.data == 1
                    ? 'Request Ambulance'
                    : snapshot.data == 2
                        ? 'Request Sent'
                        : snapshot.data == 3
                            ? 'Request Accepted'
                            : 'Request Declined',
                color: snapshot.data == 1
                    ? Colors.blue
                    : snapshot.data == 2
                        ? Colors.yellow
                        : snapshot.data == 3
                            ? Colors.green
                            : Colors.red,
              );
            },
          ),
          SizedBox(height: size.height * 0.05),
          CustomButton(
            text: 'Share My Medical details',
            onPressed: () {
              setUserDetails(widget.hospitalUid, auth.currentUser!.uid);
            },
            width: size.width * 0.5,
          ),
          SizedBox(height: size.height * 0.05),
          CustomButton(
            text: 'Share Others Medical details',
            onPressed: () {
              TextEditingController textcontroller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Enter Phone Number'),
                    content: TextField(
                      controller: textcontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          detailsUid =
                              await getUidwithPhoneNumber(textcontroller.text);
                          if (detailsUid == 'User not found') {
                            showSnackBar(
                                context: context, content: 'User not found');
                          }
                          else
                          {
                             setUserDetails(widget.hospitalUid, detailsUid);
                          }
                        },
                        child: Text('Submit'),
                      ),
                      // if(detailsUid=='User not found')
                    ],
                  );
                },
              );
            },
            width: size.width * 0.5,
          ),
        ],
      ),
    );
  }
}
