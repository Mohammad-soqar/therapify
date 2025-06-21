import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/CategoryModel.dart';

class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<CategoryModel> getCategory(String id) async {
    final doc = await _db.collection('categories').doc(id).get();
    return CategoryModel.fromJson(doc.data()!);
  }

  Future<void> saveCategory(CategoryModel category, String id) {
    return _db.collection('categories').doc(id).set(category.toJson());
  }

  Stream<CategoryModel> streamCategory(String id) {
    return _db.collection('categories').doc(id).snapshots().map(
      (snapshot) => CategoryModel.fromJson(snapshot.data()!),
    );
  }

  Future<void> deleteCategory(String id) {
    return _db.collection('categories').doc(id).delete();
  }
}
