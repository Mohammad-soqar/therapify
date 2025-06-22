import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/user.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel> getUser(String id) async {
    final doc = await _db.collection('users').doc(id).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> saveUser(UserModel user, String id) {
    return _db.collection('users').doc(id).set(user.toJson());
  }

  Stream<UserModel> streamUser(String id) {
    return _db.collection('users').doc(id).snapshots().map(
      (snapshot) => UserModel.fromJson(snapshot.data()!),
    );
  }

  Future<void> deleteUser(String id) {
    return _db.collection('users').doc(id).delete();
  }
}
