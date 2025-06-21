import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/DoctorModel.dart';

class DoctorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DoctorModel> getDoctor(String id) async {
    final doc = await _db.collection('doctors').doc(id).get();
    return DoctorModel.fromJson(doc.data()!);
  }

  Future<void> saveDoctor(DoctorModel doctor, String id) {
    return _db.collection('doctors').doc(id).set(doctor.toJson());
  }

  Stream<DoctorModel> streamDoctor(String id) {
    return _db.collection('doctors').doc(id).snapshots().map(
      (snapshot) => DoctorModel.fromJson(snapshot.data()!),
    );
  }

  Future<void> deleteDoctor(String id) {
    return _db.collection('doctors').doc(id).delete();
  }
}
