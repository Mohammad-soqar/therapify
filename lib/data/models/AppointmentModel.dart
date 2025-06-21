class AppointmentModel {
  final String patientId;
  final String doctorId;
  final String appointmentDate;
  final String appointmentTime;
  final DateTime timestamp;

  AppointmentModel({
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.timestamp,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientId: json['patientId'],
      doctorId: json['doctorId'222],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'patientId': patientId,
    'doctorId': doctorId,
    'appointmentDate': appointmentDate,
    'appointmentTime': appointmentTime,
    'timestamp': timestamp.toIso8601String(),
  };
}
