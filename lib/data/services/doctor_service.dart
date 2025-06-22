// lib/data/services/doctor_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/DoctorModel.dart';

class DoctorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Retrieves a doctor by UID and ensures the document exists.
  Future<DoctorModel> getDoctor(String id) async {
    final doc = await _db.collection('doctors').doc(id).get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('No doctor profile found for user ID: $id');
    }
    return DoctorModel.fromJson(doc.data()!);
  }

  /// Saves or updates a doctor record.
  Future<void> saveDoctor(DoctorModel doctor, String id) {
    return _db.collection('doctors').doc(id).set(doctor.toJson());
  }

  /// Streams a doctor record; throws if data is missing.
  Stream<DoctorModel> streamDoctor(String id) {
    return _db.collection('doctors').doc(id).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('Doctor document missing data for ID: $id');
      }
      return DoctorModel.fromJson(snapshot.data()!);
    });
  }

  /// Deletes a doctor record.
  Future<void> deleteDoctor(String id) {
    return _db.collection('doctors').doc(id).delete();
  }
}
