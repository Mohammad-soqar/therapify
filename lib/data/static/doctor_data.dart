import 'package:therapify/data/models/DoctorModel.dart';
import 'package:therapify/data/models/schedule_model.dart';

List<DoctorModel> doctorData = [
  DoctorModel(
    doctorId: 'doc001',
    name: 'Dr. Amina Khaled',
    phoneNumber: '+201112223344',
    consultationFee: 50,
    netConsultationFee: 45,
    followUp: 25,
    availabilityDate: '2025-07-10',
    availabilityTime: '10:00 AM - 2:00 PM',
    location: 'Cairo, Egypt',
    imageUrl: null,
    bio: 'Experienced psychiatrist with a focus on cognitive behavioral therapy.',
    workingIn: 'Cairo Mental Health Center',
    workplace: 'Cairo Mental Health Center',
    category: 'Psychiatry',
    rating: 4.5,
    isAvailable: true,
    specialization: 'Psychiatrist',
    schedule: [
      ScheduleModel(
        day: 'Monday',
        date: '2025-07-08',
        timeSlots: ['10:00 AM', '11:00 AM', '12:00 PM'],
      ),
      ScheduleModel(
        day: 'Tuesday',
        date: '2025-07-09',
        timeSlots: ['1:00 PM', '2:00 PM'],
      ),
    ],
    averageConsultationTime: 30,
  ),
];
