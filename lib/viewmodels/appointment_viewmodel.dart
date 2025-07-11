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
    String description, // Added description parameter
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final appointment = AppointmentModel(
        doctorId: doctorId,
        doctorName: '', // This can be set later if needed
        patientName: '', // This can be set later if needed
        patientId: patientId,
        description: description,
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

  Future<AppointmentModel> getAppointment(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      final appointment = await _appointmentService.getAppointment(id);
      errorMessage = null;
      return appointment;
    } catch (e) {
      errorMessage = 'Error fetching appointment: $e';
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<AppointmentModel>> getAllAppointments(String patientId) async {
    isLoading = true;
    notifyListeners();
    try {
      final appointments = await _appointmentService.getAllAppointments(patientId);
      errorMessage = null;
      return appointments;
    } catch (e) {
      errorMessage = 'Error fetching appointments: $e';
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
