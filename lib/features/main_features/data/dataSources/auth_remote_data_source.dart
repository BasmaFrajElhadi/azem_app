// data/datasources/auth_remote_data_source.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(UserModel user) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    // Store user data in Firestore or other databases if needed.
  }

  Future<User?> login(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

// data/datasources/nutritionist_remote_data_source.dart


class NutritionistRemoteDataSource {
  // Assume Firestore instance is initialized.

  Future<void> addNutritionist(NutritionistModel nutritionist) async {
    // Add nutritionist data to Firestore.
  }
}

// data/datasources/user_remote_data_source.dart


class UserRemoteDataSource {
  // Assume Firestore instance is initialized.

  Future<void> addUser(RegularUserModel user) async {
    // Add user data to Firestore.
  }
}
