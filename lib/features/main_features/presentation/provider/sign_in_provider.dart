import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/useCases/auth_use_case.dart';

class SignInProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase = LoginUseCase();

  // User data
  String _email = '';
  String _password = '';

  // State variables
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters for fields and state variables
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Setters to update each field, notifying listeners on change
  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Method to sign in using email and password
  Future<void> signIn(BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Sign in with email and password
      final userCredential = await _loginUseCase.login(
        email: _email,
        password: _password,
      );

      // Get the user ID
      final uid = userCredential.user?.uid;

      if (uid != null) {
        // Fetch the user's role from Firestore
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final role = userDoc.get('role');

        // Navigate to a screen based on the role
        if (role == 'user') {
          Navigator.pushReplacementNamed(context, 'Home');
        } else if (role == 'أخصائي تغذية'|| role == 'مدرب') {
          Navigator.pushReplacementNamed(context, 'ExpertHomeScreen');
        }else {
          // Optional: handle any unexpected role
          _errorMessage = 'Invalid role assigned to this user.';
          notifyListeners();
        }
      }
    } catch (e) {
      // Set error message if there's an issue
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
