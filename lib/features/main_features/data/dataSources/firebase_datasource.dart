import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseDataSource {
  final FirebaseFirestore firestore;

  FirebaseDataSource(this.firestore);

  Future<UserModel?> getUserByEmail(String email) async {
    var snapshot = await firestore.collection('Users').where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromJson(snapshot.docs.first.data());
    }
    return null;
  }
}
