import 'package:emedoc/ambulance/ambulance_repository.dart';
import 'package:emedoc/emedoc_for_hospital/Screens/get_user_details.dart';
import 'package:emedoc/emedoc_for_hospital/Widget/get_userdata.dart';
import 'package:emedoc/models/emergency_model.dart';
import 'package:emedoc/models/user_model.dart';
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/utils/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Selectedemergency extends StatefulWidget {
  const Selectedemergency({super.key, required this.emergency});
  final EmergencyModel emergency;

  @override
  State<Selectedemergency> createState() => _SelectedemergencyState();
}

class _SelectedemergencyState extends State<Selectedemergency> {
  Userinfo? user;
  Userinfo? detailsUser;
  @override
  void initState() {
    super.initState();
    getUser();
    getDetailsUser();
  }

  void getUser() async {
    Userinfo? temp = await getCurrentUserData(widget.emergency.uid);
    setState(() {
      user = temp;
    });
  }

  void getDetailsUser() async {
    String tempuid =
        await checkDetailsUid(auth.currentUser!.uid, widget.emergency.uid);
    detailsUser = await getCurrentUserData(tempuid);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Getting User Details...'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user!.firstName, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              height: size.height * 0.2,
              child: StreamBuilder(
                stream: checkAmbulanceStatus(
                    auth.currentUser!.uid, widget.emergency.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 15),
                      snapshot.data == 1
                          ? const Text(
                              'Ambulance not yet called',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )
                          : snapshot.data == 2
                              ? Text(
                                  'Ambulance requested by user',
                                  style: TextStyle(
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              : snapshot.data == 3
                                  ? const Text(
                                      'Ambulance request accepted',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  : const Text(
                                      'Ambulance request declined',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            onPressed: () {
                              updateAmbulanceStatus(auth.currentUser!.uid,
                                  widget.emergency.uid, 3);
                            },
                            text: 'Accept',
                            color: Colors.green,
                            width: size.width * 0.4,
                          ),
                          CustomButton(
                            onPressed: () {
                              updateAmbulanceStatus(auth.currentUser!.uid,
                                  widget.emergency.uid, 4);
                            },
                            text: 'Decline',
                            width: size.width * 0.4,
                            color: Colors.red,
                          )
                        ],
                      )
                      //userdetails
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Open user details',
                  onPressed: () {
                    if (detailsUser != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Userdetailscreen(user: detailsUser!),
                        ),
                      );
                    }
                  },
                  width: size.width * 0.7,
                ),
                IconButton(
                    onPressed: getDetailsUser,
                    icon: const Icon(Icons.refresh_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
