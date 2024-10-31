import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpertRemoteDataSource(this.firestore);

  Future<List<Map<String, dynamic>>> fetchExperts() async {
    final snapshot = await firestore.collection('Users').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateLoves(String expertId, int currentLoves) async {
    final docRef = firestore.collection('Users').doc(expertId);
    await docRef.update({'loves': currentLoves + 1});
  }
}
