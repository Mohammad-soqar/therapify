import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:therapify/data/models/AppointmentModel.dart';

class AppointmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AppointmentModel> getAppointment(String id) async {
    final doc = await _db.collection('appointments').doc(id).get();
    return AppointmentModel.fromJson(doc.data()!);
  }

  Future<DocumentReference> addAppointment(AppointmentModel appointment) async {
    final docRef =
        await _db.collection('appointments').add(appointment.toJson());
    docRef.update({
      'appointmentId': docRef.id,
    });

    final doctorDoc = await _db.collection('users').doc(appointment.doctorId).get();
    final doctorName = doctorDoc.data()?['name'] ?? '';
    await docRef.update({
      'doctorName': doctorName,
    });

     final patientDoc = await _db.collection('users').doc(appointment.patientId).get();
    final patientName = patientDoc.data()?['name'] ?? '';
    await docRef.update({
      'patientName': patientName,
    });
    

    // Add appointment to patient's subcollection with appointmentId set
    final appointmentData = appointment.toJson();
    appointmentData['appointmentId'] = docRef.id;
    appointmentData['doctorName'] = doctorName;
    appointmentData['patientName'] = patientName;
    await _db
      .collection('patients')
      .doc(appointment.patientId)
      .collection('appointments')
      .doc(docRef.id)
      .set(appointmentData);

       await _db
      .collection('doctors')
      .doc(appointment.doctorId)
      .collection('appointments')
      .doc(docRef.id)
      .set(appointmentData);

    return docRef;
  }

  Future<List<AppointmentModel>> getAllAppointments(String patientId) async {
    final querySnapshot = await _db
        .collection('patients')
        .doc(patientId)
        .collection('appointments')
        .get();
    return querySnapshot.docs
        .map((doc) => AppointmentModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> deleteAppointment(String id) {
    return _db.collection('appointments').doc(id).delete();
  }
}
