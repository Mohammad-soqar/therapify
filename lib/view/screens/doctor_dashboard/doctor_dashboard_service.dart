import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'doctor_dashboard_model.dart';

class DoctorDashboardService {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<DashboardStats> fetchDashboardStats() async {
    final appointmentsSnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: userId)
        .get();

    final appointments = appointmentsSnapshot.docs;
    final uniquePatientIds = appointments
        .map((doc) => doc['patientId'])
        .toSet()
        .toList();

    return DashboardStats(
      totalPatients: uniquePatientIds.length,
      totalAppointments: appointments.length,
      isAvailable: true,
    );
  }

  Future<List<Patient>> fetchPatientsByIds(List<String> patientIds) async {
    final List<Patient> patients = [];

    for (final id in patientIds) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        patients.add(Patient(
          id: id,
          name: data['name'] ?? 'Unknown',
          age: data['age'] ?? 0,
          condition: data['condition'] ?? 'Not specified',
        ));
      }
    }

    return patients;
  }

  Future<List<Appointment>> fetchAppointments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Appointment(
        id: doc.id,
        patientId: data['patientId'] ?? '',
        patientName: data['patientName'] ?? 'Unknown',
        dateTime: _parseDateTime(data['appointmentDate'], data['appointmentTime']),
         description: data['description'] ?? '',
      );
    }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  DateTime _parseDateTime(String? dateStr, String? timeStr) {
    if (dateStr == null || timeStr == null) return DateTime.now();

    try {
      final dateParts = dateStr.split('-'); // yyyy-MM-dd
      final timeParts = timeStr.split(':'); // HH:mm

      return DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (_) {
      return DateTime.now();
    }
  }
}
