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

    // Fetch all appointments for this doctor
    appointments = await _service.fetchAppointments();

    // Extract unique patient IDs
    final uniquePatientIds = <String>{};
    final uniqueAppointments = <Appointment>[];

    for (var appt in appointments) {
      if (uniquePatientIds.add(appt.patientId)) {
        uniqueAppointments.add(appt);
      }
    }

    // Fetch only unique patients
    patients = await _service.fetchPatientsByIds(uniquePatientIds.toList());

    // Update dashboard stats
    stats = DashboardStats(
      totalPatients: patients.length,
      totalAppointments: appointments.length,
      isAvailable: true,
    );

    isLoading = false;
    notifyListeners();
  }

  void toggleAvailability() {
    if (stats != null) {
      stats = DashboardStats(
        totalPatients: stats!.totalPatients,
        totalAppointments: stats!.totalAppointments,
        isAvailable: !stats!.isAvailable,
      );
      notifyListeners();
    }
  }
}
