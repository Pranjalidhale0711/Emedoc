// import 'package:flutter/material.dart';

// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class CallPage extends StatelessWidget {
//   const CallPage({Key? key, required this.callID, required this.uName})
//       : super(key: key);
//   final String callID;
//   final String uName;

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID:
//           941230644, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign:
//           '000ffff656ca0aec92e504b5b61fdeb40b976b0d8f2cf9ce4313790274f1e95c', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: uName,
//       userName: uName,
//       callID: callID,
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     );
//   }
// }