import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/patient.dart';

class PatientService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<PatientModel> getPatient(String id) async {
    final doc = await _db.collection('patients').doc(id).get();
    return PatientModel.fromJson(doc.data()!);
  }

  Future<void> savePatient(PatientModel patient, String id) {
    return _db.collection('patients').doc(id).set(patient.toJson());
  }

  Stream<PatientModel> streamPatient(String id) {
    return _db.collection('patients').doc(id).snapshots().map(
      (snapshot) => PatientModel.fromJson(snapshot.data()!),
    );
  }

  Future<void> deletePatient(String id) {
    return _db.collection('patients').doc(id).delete();
  }
}
