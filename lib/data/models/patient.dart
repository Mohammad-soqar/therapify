class PatientModel {
  final String patientId;

  PatientModel({required this.patientId});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(patientId: json['patientId']);
  }

  Map<String, dynamic> toJson() => {
    'patientId': patientId,
  };
}
