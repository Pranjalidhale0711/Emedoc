// ... (other imports)


import 'package:emedoc/utils/shortcut.dart';
import 'package:emedoc/models/hospital_model.dart';
import 'package:emedoc/emedoc_for_hospital/Screens/hospital_main_screen.dart';
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/emedoc_for_hospital/repositories/auth_repository.dart';
import 'package:emedoc/emedoc_for_hospital/repositories/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class HospitalInfoScreen extends StatefulWidget {
  const HospitalInfoScreen({Key? key}) : super(key: key);

  @override
  _HospitalInfoScreenState createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  // ... (other variables and controllers)
  
  Position? _currentPosition;
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController phonenoController = TextEditingController();

  // ... (other methods)

  Future<void> _getCurrentPosition() async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _finishLoginHospital() {
    if (_currentPosition == null) {
      showSnackBar(context: context, content: 'Location Not Received');
      return;
    }
    Hospitalinfo hospital = Hospitalinfo(
      name: nameController.text,
      address: addressController.text,
      phoneNumber: phonenoController.text,
      latitude: _currentPosition!.latitude.toString(),
      longtitude: _currentPosition!.longitude.toString(),
    );
    saveHospitalData(hospital);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HospitalMainScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Hospita; Information', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Name of Hospital'),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Address'),
                      controller: addressController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Phone Number'),
                      controller: phonenoController,
                    ),
                   
                    ElevatedButton(
                      onPressed: _getCurrentPosition,
                      child: const Text("Get Current Location"),
                    ),
                     Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                  
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _finishLoginHospital,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
