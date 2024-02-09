class Call {
  final String callerId;
  final String callerName;
  final String receiverId;
  final String receiverName;
  final String callId;
  final bool hasDialled;

  Call({
    required this.callerId,
    required this.callerName,
    required this.receiverId,
    required this.receiverName,
    required this.callId,
    required this.hasDialled,
  });

  Map<String, dynamic> toMap() {
    return {
      'callerId': callerId,
      'callerName': callerName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'callId': callId,
      'hasDialled': hasDialled,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      callerId: map['callerId'] ?? '',
      callerName: map['callerName'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      callId: map['callId'] ?? '',
      hasDialled: map['hasDialled'] ?? false,
    );
  }
}