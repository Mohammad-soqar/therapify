class DoctorModel {
  final String doctorId;
  final String category;
  final double consultationFee;
  final double netConsultationFee;
  final bool followUp;
  final String availabilityDate;
  final String availabilityTime;
  final String location;

  DoctorModel({
    required this.doctorId,
    required this.category,
    required this.consultationFee,
    required this.netConsultationFee,
    required this.followUp,
    required this.availabilityDate,
    required this.availabilityTime,
    required this.location,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'],
      category: json['category'],
      consultationFee: json['consultationFee'].toDouble(),
      netConsultationFee: json['netConsultationFee'].toDouble(),
      followUp: json['followUp'],
      availabilityDate: json['availabilityDate'],
      availabilityTime: json['availabilityTime'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
    'doctorId': doctorId,
    'category': category,
    'consultationFee': consultationFee,
    'netConsultationFee': netConsultationFee,
    'followUp': followUp,
    'availabilityDate': availabilityDate,
    'availabilityTime': availabilityTime,
    'location': location,
  };
}
