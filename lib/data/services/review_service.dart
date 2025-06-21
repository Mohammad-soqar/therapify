import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapify/data/models/ReviewModel.dart';

class ReviewService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ReviewModel> getReview(String id) async {
    final doc = await _db.collection('reviews').doc(id).get();
    return ReviewModel.fromJson(doc.data()!);
  }

  Future<void> saveReview(ReviewModel review, String id) {
    return _db.collection('reviews').doc(id).set(review.toJson());
  }

  Stream<ReviewModel> streamReview(String id) {
    return _db.collection('reviews').doc(id).snapshots().map(
      (snapshot) => ReviewModel.fromJson(snapshot.data()!),
    );
  }

  Future<void> deleteReview(String id) {
    return _db.collection('reviews').doc(id).delete();
  }
}
