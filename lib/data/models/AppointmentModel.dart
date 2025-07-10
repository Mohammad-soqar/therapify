class AppointmentModel {
  final String? appointmentId;

  final String patientId;
  final String patientName; // Optional, can be fetched later
  final String doctorId;
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final DateTime createdTime;

  AppointmentModel({
    this.appointmentId,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.createdTime,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'],
      patientName: json['patientName'],
      doctorName: json['doctorName'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      createdTime: DateTime.parse(json['createdTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        'appointmentId': appointmentId,
        'patientId': patientId,
        'patientName': patientName,
        'doctorName': doctorName,
        'doctorId': doctorId,
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'createdTime': createdTime.toIso8601String(),
      };
}
