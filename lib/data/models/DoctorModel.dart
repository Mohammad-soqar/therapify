import 'package:therapify/data/models/schedule_model.dart';

class DoctorModel {
  final String doctorId;
  final String name;
  final double consultationFee;
  final double netConsultationFee;
  final double followUp;
  final String availabilityDate;
  final String availabilityTime;
  final String location;
  final String? imageUrl;
  final String? specialization;
  final double? rating;
  final String? category;
  final String phoneNumber;
  final List<ScheduleModel> schedule;
  final String? workplace;
  final String? bio;
  final String? workingIn;
  final int averageConsultationTime;

  DoctorModel({
    required this.doctorId,
    required this.name,
    required this.consultationFee,
    required this.netConsultationFee,
    required this.followUp,
    required this.availabilityDate,
    required this.availabilityTime,
    required this.location,
    required this.phoneNumber,
    this.bio,
    this.workingIn,
    this.workplace,
    this.imageUrl,
    this.specialization,
    this.rating,
    this.category,
    required this.schedule,
    required this.averageConsultationTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'],
      name: json['name'],
      consultationFee: (json['consultationFee'] ?? 0).toDouble(),
      netConsultationFee: (json['netConsultationFee'] ?? 0).toDouble(),
      followUp: (json['followUp'] ?? 0).toDouble(),
      availabilityDate: json['availabilityDate'] ?? '',
      availabilityTime: json['availabilityTime'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'],
      specialization: json['specialization'],
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      category: json['category'],
      phoneNumber: json['phoneNumber'],
      workplace: json['workplace'],
      bio: json['bio'],
      workingIn: json['workingIn'],
      schedule: (json['schedule'] as List<dynamic>?)
              ?.map((e) => ScheduleModel.fromJson(e))
              .toList() ??
          [],
      averageConsultationTime: json['averageConsultationTime'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'name': name,
        'consultationFee': consultationFee,
        'netConsultationFee': netConsultationFee,
        'followUp': followUp,
        'availabilityDate': availabilityDate,
        'availabilityTime': availabilityTime,
        'location': location,
        'imageUrl': imageUrl,
        'specialization': specialization,
        'rating': rating,
        'category': category,
        'phoneNumber': phoneNumber,
        'bio': bio,
        'workingIn': workingIn,
        'schedule': schedule.map((e) => e.toJson()).toList(),
        'averageConsultationTime': averageConsultationTime,
      };
}
