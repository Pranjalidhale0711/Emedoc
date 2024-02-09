import 'package:emedoc/models/user_model.dart';
import 'package:flutter/material.dart';

class Userdetailscreen extends StatelessWidget {
  const Userdetailscreen({Key? key, required this.user}) : super(key: key);
  final Userinfo user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lasttName}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('First Name'),
                subtitle: Text(user.firstName),
              ),
              ListTile(
                title: Text('Last Name'),
                subtitle: Text(user.lasttName),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: Text(user.address),
              ),
              ListTile(
                title: Text('Phone Number'),
                subtitle: Text(user.phoneNumber),
              ),
              ListTile(
                title: Text('Blood Group'),
                subtitle: Text(user.bloodGroup),
              ),
              ListTile(
                title: Text('Diabetes'),
                subtitle: Text(user.diabeties ? 'Yes' : 'No'),
              ),
              ListTile(
                title: Text('Allergies'),
                subtitle: Text(user.allergies),
              ),
              ListTile(
                title: Text('Hypertension'),
                subtitle: Text(user.hypertension ? 'Yes' : 'No'),
              ),
              ListTile(
                title: Text('Asthma'),
                subtitle: Text(user.asthama ? 'Yes' : 'No'),
              ),
              ListTile(
                title: Text('Family Doctor Name'),
                subtitle: Text(user.nameOfFamilyDoc),
              ),
              ListTile(
                title: Text('Family Doctor Number'),
                subtitle: Text(user.numOfFamilyDoc),
              ),
              ListTile(
                title: Text('Special Instructions'),
                subtitle: Text(user.specialInstructions),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
