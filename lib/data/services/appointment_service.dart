import 'package:cloud_firestore/cloud_firestore.dart';
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

    await _db
        .collection('patients')
        .doc(appointment.patientId)
        .collection('appointments')
        .doc(docRef.id)
        .set(appointment.toJson());

    return docRef;
  }

  Stream<AppointmentModel> streamAppointment(String id) {
    return _db.collection('appointments').doc(id).snapshots().map(
          (snapshot) => AppointmentModel.fromJson(snapshot.data()!),
        );
  }

  Future<void> deleteAppointment(String id) {
    return _db.collection('appointments').doc(id).delete();
  }
}
