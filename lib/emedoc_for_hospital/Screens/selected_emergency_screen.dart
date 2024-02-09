import 'package:emedoc/ambulance/ambulance_repository.dart';
import 'package:emedoc/emedoc_for_hospital/Widget/get_userdata.dart';
import 'package:emedoc/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Selectedemergency extends StatefulWidget {
  Selectedemergency({super.key, required this.uid});
  final String uid;

  @override
  State<Selectedemergency> createState() => _SelectedemergencyState();
}

class _SelectedemergencyState extends State<Selectedemergency> {
  Userinfo? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser() async {
    Userinfo? temp = await getCurrentUserData(widget.uid);
    setState(() {
      user = temp;
    });
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
        title: Text(user!.firstName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              height: size.height * 0.2,
              child: StreamBuilder(
                stream: checkAmbulanceStatus(auth.currentUser!.uid, widget.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Text(
                        snapshot.data == 2
                            ? 'Ambulance called'
                            : 'Ambulance called',
                        style: TextStyle(
                            color: snapshot.data == 2
                                ? const Color.fromARGB(255, 33, 243, 58)
                                : Colors.blue),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                updateAmbulanceStatus(auth.currentUser!.uid,widget.uid, 3);
                              },
                              icon: Icon(Icons.plus_one)),
                          IconButton(
                              onPressed: () {
                                updateAmbulanceStatus(auth.currentUser!.uid,widget.uid, 4);
                              },
                              icon: Icon(Icons.wrong_location))
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
