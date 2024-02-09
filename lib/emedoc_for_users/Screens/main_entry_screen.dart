import 'package:emedoc/emedoc_for_users/Screens/map_screen.dart';
import 'package:emedoc/emedoc_for_users/Screens/user_info_screen.dart';
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/emedoc_for_users/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Welcome User',
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
                  onTap: () => signOut(context)),
              PopupMenuItem(
                child: const Text(
                  'Update Information',
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen())),
              )
            ],
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
            print('Emergency button pressed!');
          },
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.red, // Change the color as needed
              shape: BoxShape.circle,
            ),
            child: Center(
              
              child: InkWell(
                onTap: (){},
                child: Text(
                  'Emergency',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
