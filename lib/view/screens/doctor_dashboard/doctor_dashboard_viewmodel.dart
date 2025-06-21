import 'package:flutter/material.dart';
import 'doctor_dashboard_service.dart';
import 'doctor_dashboard_model.dart';

class DoctorDashboardViewModel extends ChangeNotifier {
  final DoctorDashboardService _service = DoctorDashboardService();

  bool isLoading = true;

  DashboardStats? stats;
  List<Patient> patients = [];
  List<Appointment> appointments = [];

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    stats = await _service.fetchDashboardStats();
    patients = await _service.fetchPatients();
    appointments = await _service.fetchAppointments();

    isLoading = false;
    notifyListeners();
  }

  void toggleAvailability() {
    if (stats != null) {
      stats = DashboardStats(
        totalPatients: stats!.totalPatients,
        totalAppointments: stats!.totalAppointments,
        totalEarnings: stats!.totalEarnings,
        isAvailable: !stats!.isAvailable,
      );
      notifyListeners();
    }
  }
}
