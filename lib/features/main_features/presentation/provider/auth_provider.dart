import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String? emailError;
  String? passwordError;
  String? emailExistsError;

  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isLoading = false;
      notifyListeners();
      return userCredential;
    } catch (e) {
      isLoading = false;
      passwordError = 'Login failed. Please check your credentials.';
      notifyListeners();
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      isLoading = false;
      notifyListeners();
      return userCredential;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    if (email.isNotEmpty) {
      QuerySnapshot querySnapshot = await _firestore.collection('Users').where('email', isEqualTo: email).get();
      return querySnapshot.docs.isNotEmpty;
    }
    return false;
  }
}
