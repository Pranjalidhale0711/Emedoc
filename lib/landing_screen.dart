import 'package:emedoc/emedoc_for_hospital/Screens/login_screen_hospital.dart';
import 'package:emedoc/emedoc_for_users/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who Are You'),
      ),
      body: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreenUser()));
              },
              child: Text('User')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreenHospital()));
              },
              child: Text('Hospital')),
        ],
      ),
    );
  }
}
