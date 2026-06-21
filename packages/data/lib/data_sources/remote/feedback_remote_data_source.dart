import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/models/feedback_model.dart';

class FeedbackRemoteDataSource {
  final FirebaseFirestore _firestore;

  FeedbackRemoteDataSource(this._firestore);

  Future<String> saveFeedback(FeedbackModel feedback) async {
    try {
      final docRef = _firestore.collection('feedback').doc();
      await docRef.set({...feedback.toJson(), 'id': docRef.id});
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to save feedback: $e');
    }
  }
}
