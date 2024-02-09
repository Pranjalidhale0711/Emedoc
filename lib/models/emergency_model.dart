class EmergencyModel {
  String uid;
  String latitude;
  String longtitude;
  int ambulanceStatus;
  bool vidCall;

  EmergencyModel({
    required this.uid,
    required this.latitude,
    required this.longtitude,
    required this.ambulanceStatus,
    required this.vidCall,
   
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'latitude': latitude,
      'longtitude': longtitude,
      'ambulanceStatus': ambulanceStatus,
      'vidCall': vidCall,
     
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      uid: map['uid'] ?? '',
      latitude: map['latitude'] ?? '',
      longtitude: map['longtitude'] ?? '',
      ambulanceStatus: map['ambulanceStatus'] ?? 1,
      vidCall: map['vidCall'] ?? false,
     
    );
  }
}
