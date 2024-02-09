import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emedoc/emedoc_for_hospital/Widget/get_userdata.dart';
import 'package:emedoc/models/emergency_model.dart';
import 'package:emedoc/emedoc_for_users/repositories/auth_repository.dart';
import 'package:geolocator/geolocator.dart';

Future<void> setEmergency(String hospitalUid, Position currrentLocation) async {
  print('request e,ergency');

  double latitude = currrentLocation.latitude;
  double longitude = currrentLocation.longitude;

  // Check if eme already exists
  DocumentSnapshot emeSnapshot = await FirebaseFirestore.instance
      .collection('emergency')
      .doc(hospitalUid)
      .collection('users')
      .doc(auth.currentUser!.uid)
      .get();

  if (!emeSnapshot.exists) {
    EmergencyModel eme = EmergencyModel(
      uid: auth.currentUser!.uid,
      latitude: latitude.toString(),
      longtitude: longitude.toString(),
      ambulanceStatus: 1,
      vidCall: false,
    );

    try {
      await FirebaseFirestore.instance
          .collection('emergency')
          .doc(hospitalUid)
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(eme.toMap());
    } on Exception catch (e) {
      print('Error setting initial emergency: $e');
    }
  } else {
    print('Emergency data already exists.');
  }
}

Future<void> requestAmbulance(
    String hospitalUid, Position currrentLocation) async {
  print('request ambulanhuuhuunnujniuj');
  await setEmergency(hospitalUid, currrentLocation);
  try {
    await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'ambulanceStatus': 1});

    print('emergency');
    print(hospitalUid);
    print(auth.currentUser!.uid);
    print('model');
     updateAmbulanceStatus(hospitalUid, auth.currentUser!.uid, 2);
  } catch (e) {
    print('Error requesting ambulance: $e');
  }
}

Future<void> requestVidCall(
    String hospitalUid, Position currrentLocation) async {
  print('request ambulanhuuhuunnujniuj');
  await setEmergency(hospitalUid, currrentLocation);
  try {
    await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'vidCall': true});

    print('emergency');
    print(hospitalUid);
    print(auth.currentUser!.uid);
    print('model');
  } catch (e) {
    print('Error requesting ambulance: $e');
  }
}

Stream<int> checkAmbulanceStatus(String hospitalUid, String userUid) {
  return firestore
      .collection('emergency')
      .doc(hospitalUid)
      .collection('users')
      .doc(userUid)
      .snapshots()
      .map((event) {
        if (event.exists) {
          return event.data()!['ambulanceStatus'] ?? 1;
        } else {
          return 1;
        }
      });
}

void updateAmbulanceStatus(
    String hospitalUid, String userUid, int value) async {
  await FirebaseFirestore.instance
      .collection('emergency')
      .doc(hospitalUid)
      .collection('users')
      .doc(userUid)
      .update({'ambulanceStatus': value});
}
