import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emedoc/emedoc_for_hospital/Screens/hospital_info_screen.dart';
import 'package:emedoc/emedoc_for_hospital/Screens/selected_emergency_screen.dart';
import 'package:emedoc/emedoc_for_hospital/Widget/get_userdata.dart';
import 'package:emedoc/emedoc_for_hospital/repositories/auth_repository.dart';
import 'package:emedoc/models/emergency_model.dart';
import 'package:emedoc/models/user_model.dart';
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/utils/shortcut.dart';
import 'package:flutter/material.dart';

class HospitalMainScreen extends StatefulWidget {
  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  State<HospitalMainScreen> createState() => _HospitalMainScreenState();
}

class _HospitalMainScreenState extends State<HospitalMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text(
            'Welcome Hospital',
            style: TextStyle(color: textColor),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 14, 13, 13),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: const Text(
                      'Log out',
                    ),
                    onTap: () => signOutHospital(context)),
                PopupMenuItem(
                  child: const Text(
                    'Update Information',
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HospitalInfoScreen())),
                )
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Other widgets (e.g., header, input field) can go here

              Container(
                // Adjust height as needed
                height: 300, // Example height
                child: StreamBuilder<List<EmergencyModel>>(
                  stream: getEmergencies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No emergencies found.');
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var user = snapshot.data![index];
                        // Create a widget to display user ID (e.g., ListTile, Card)
                        // Replace the 'return null;' line with your custom widget

                        return ListTile(
                          title: Text(user.uid),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Selectedemergency(uid: user.uid)));
                          },

                          // Other relevant properties (e.g., onTap, trailing)
                        );
                      },
                    );
                  },
                ),
              ),

              // Other widgets (e.g., input field, footer) can go here
            ],
          ),
        ));
  }
}