import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emedoc/emedoc_for_hospital/Widget/get_userdata.dart';
import 'package:emedoc/models/emergency_model.dart';
import 'package:emedoc/emedoc_for_users/repositories/auth_repository.dart';
import 'package:geolocator/geolocator.dart';

Future<void> setEmergency(String hospitalUid, Position currrentLocation) async {
  double latitude = currrentLocation.latitude;
  double longitude = currrentLocation.longitude;

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
      name: currentUser!.firstName,
      detailsUid: 'Not yet provided',
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
  await setEmergency(hospitalUid, currrentLocation);
  try {
    await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'ambulanceStatus': 1});

    updateAmbulanceStatus(hospitalUid, auth.currentUser!.uid, 2);
  } catch (e) {
    print('Error requesting ambulance: $e');
  }
}

Future<void> requestVidCall(
    String hospitalUid, Position currrentLocation) async {
  await setEmergency(hospitalUid, currrentLocation);
  try {
    await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'vidCall': true});
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

Future<String> checkDetailsUid(String hospitalUid, String userUid) async {
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(userUid)
        .get();

    if (snapshot.exists) {
      return snapshot.data()?['detailsUid'] ?? 'Not yet provided';
    } else {
      return 'Not yet provided';
    }
  } catch (e) {
    print('Error checking detailsUid: $e');
    rethrow; // Re-throw the error to handle it in the calling code
  }
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

Future<void> setUserDetails(String hospitalUid, String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection('emergency')
        .doc(hospitalUid)
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'detailsUid': uid});
  } catch (e) {
    print('Error requesting ambulance: $e');
  }
}

Future<String> getUidwithPhoneNumber(String number) async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var doc in querySnapshot.docs) {
    if (doc['phoneNumber'] == number) {
      return doc.id;
    }
  }

  return 'User not found';
}


