
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emedoc/call/screens/call_screen.dart';
import 'package:emedoc/emedoc_for_users/repositories/auth_repository.dart';
import 'package:emedoc/models/call_model.dart';
import 'package:emedoc/utils/shortcut.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Stream<DocumentSnapshot> get callStream =>
    firestore.collection('call').doc(auth.currentUser!.uid).snapshots();

void makeCall(
  BuildContext context,
  String receiverName,
  String receiverUid,
  String receiverProfilePic,
) async {
  String callId = const Uuid().v1();

  Call senderCallData = Call(
    callerId: auth.currentUser!.uid,
    callerName: currentUser!.name,
    callerPic: currentUser!.profilePic,
    receiverId: receiverUid,
    receiverName: receiverName,
    receiverPic: receiverProfilePic,
    callId: callId,
    hasDialled: true,
  );

  Call receiverCallData = Call(
    callerId: auth.currentUser!.uid,
    callerName: currentUser!.name,
    callerPic: currentUser!.profilePic,
    receiverId: receiverUid,
    receiverName: receiverName,
    receiverPic: receiverProfilePic,
    callId: callId,
    hasDialled: false,
  );

  try {
    await firestore
        .collection('call')
        .doc(auth.currentUser!.uid)
        .set(senderCallData.toMap());
    await firestore
        .collection('call')
        .doc(receiverUid)
        .set(receiverCallData.toMap());

    push(
      context: context,
      screen: () => CallScreen(
        channelId: senderCallData.callId,
        call: senderCallData,
      ),
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
}

void endCall(
  BuildContext context,
  String callerUid,
  String receiverUid,
) async {
  try {
    await firestore.collection('call').doc(callerUid).delete();
    await firestore.collection('call').doc(receiverUid).delete();

    Navigator.of(context).pop();
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
}
