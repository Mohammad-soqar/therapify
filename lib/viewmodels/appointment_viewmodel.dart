import 'package:flutter/material.dart';
import 'package:therapify/data/models/AppointmentModel.dart';
import 'package:therapify/data/services/appointment_service.dart';

class AppointmentViewmodel extends ChangeNotifier {
  final AppointmentService _appointmentService;
  bool isLoading = false;
  String? errorMessage;

  AppointmentViewmodel({
    AppointmentService? appointmentService,
  }) : _appointmentService = appointmentService ?? AppointmentService();

  Future<void> addAppointment(
    String doctorId,
    String patientId,
    String appointmentDate,
    String appointmentTime,
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final appointment = AppointmentModel(
        doctorId: doctorId,
        patientId: patientId,
        appointmentTime: appointmentTime,
        appointmentDate: appointmentDate,
        createdTime: DateTime.now(),
      );

      final docRef = await _appointmentService.addAppointment(appointment);

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error adding appointment: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
