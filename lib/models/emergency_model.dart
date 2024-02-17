class EmergencyModel {
  String uid;
  String latitude;
  String longtitude;
  int ambulanceStatus;
  bool vidCall;
  String name;
  String detailsUid;

  EmergencyModel({
    required this.uid,
    required this.latitude,
    required this.longtitude,
    required this.ambulanceStatus,
    required this.vidCall,
    required this.name,
    required this.detailsUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'latitude': latitude,
      'longtitude': longtitude,
      'ambulanceStatus': ambulanceStatus,
      'vidCall': vidCall,
      'name': name,
      'detailsUid': detailsUid,
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      uid: map['uid'] ?? '',
      latitude: map['latitude'] ?? '',
      longtitude: map['longtitude'] ?? '',
      ambulanceStatus: map['ambulanceStatus'] ?? 1,
      vidCall: map['vidCall'] ?? false,
      name: map['name'] ?? '',
      detailsUid: map['detailsUid'] ?? '',
    );
  }
}
