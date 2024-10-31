import 'package:flutter/material.dart';

import '../../domain/useCases/auth_use_case.dart';

class SignUpProvider with ChangeNotifier {
  final SignUpUseCase _signUpUseCase = SignUpUseCase();

  // user data
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _gender = 'Male';
  DateTime _birthdate = DateTime.now();
  String _height = '';
  String _weight = '';
  String _goal = '';
  String _healthIssue='';

  // State variables
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters for fields and state variables
  String get email => _email;
  String get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  DateTime get birthdate => _birthdate;
  String get height => _height;
  String get weight => _weight;
  String get goal => _goal;
  String get healthIssue => _healthIssue;

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

  void updateFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }
  void updateLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void updateGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void updateBirthdate(DateTime birthdate) {
    _birthdate = birthdate;
    notifyListeners();
  }

  void updateHeight(String height) {
    _height = height;
    notifyListeners();
  }

  void updateWeight(String weight) {
    _weight = weight;
    notifyListeners();
  }

  void updateGoal(String goal) {
    _goal = goal;
    notifyListeners();
  }

  void updateHealthIssue(String healthIssue) {
    _healthIssue = healthIssue;
    notifyListeners();
  }

  // Method to create an account using the provided fields
  Future<void> createAccount(BuildContext context) async {
    // Reset loading state and error message
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _signUpUseCase.createAccount(
        email: _email,
        password: _password,
        firstName: _firstName,
        lastName: _lastName,
        gender: _gender,
        birthdate: _birthdate,
        height: _height,
        weight: _weight,
        goal: _goal,
          healthIssue: healthIssue,
      );

      // Navigate to the home screen if successful
      Navigator.pushReplacementNamed(context, 'Home');
    } catch (e) {
      // Set error message if there's an issue
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
