import 'dart:async';
import 'doctor_dashboard_model.dart';

class DoctorDashboardService {
  Future<DashboardStats> fetchDashboardStats() async {
    await Future.delayed(const Duration(seconds: 1));
    return DashboardStats(
      totalPatients: 14,
      totalAppointments: 6,
      totalEarnings: 2350.75,
      isAvailable: true,
    );
  }

  Future<List<Patient>> fetchPatients() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Patient(id: '1', name: 'John Doe', age: 29, condition: 'Anxiety'),
      Patient(id: '2', name: 'Sarah Ali', age: 35, condition: 'Depression'),
    ];
  }

  Future<List<Appointment>> fetchAppointments() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Appointment(
        id: 'a1',
        patientName: 'John Doe',
        dateTime: DateTime.now().add(const Duration(hours: 3)),
      ),
      Appointment(
        id: 'a2',
        patientName: 'Sarah Ali',
        dateTime: DateTime.now().add(const Duration(days: 1)),
      ),
    ];
  }
}
