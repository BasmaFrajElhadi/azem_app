import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider with ChangeNotifier {
  // User data
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _gender = 'Male';
  DateTime _birthdate = DateTime.now();
  String _height = '';
  String _weight = '';
  String _goal = '';
  String _healthIssue = '';

  // State variables
  bool _isLoading = false;
  String _errorMessage = '';

  // Constructor
  CurrentUserProvider() {
    _initializeUser();
  }

  // Initialize user details from Firebase
  Future<void> _initializeUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        _email = user.email ?? '';
        _firstName = userData['firstName'];
        _lastName = userData['lastName'];
        _gender = userData['gender'];
        _birthdate = (userData['birthdate'] as Timestamp).toDate();
        _height = userData['height'];
        _weight = userData['weight'];
        _goal = userData['goal'];
        _healthIssue = userData['healthIssue'];

        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Failed to load user data: $e";
      notifyListeners();
    }
  }

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

  int get age {
    final now = DateTime.now();
    int age = now.year - _birthdate.year;
    if (now.month < _birthdate.month ||
        (now.month == _birthdate.month && now.day < _birthdate.day)) {
      age--;
    }
    return age;
  }

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

  Future<void> saveUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _errorMessage = "No user is currently signed in.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'firstName': _firstName,
        'lastName': _lastName,
        'gender': _gender,
        'birthdate': Timestamp.fromDate(_birthdate),
        'height': _height,
        'weight': _weight,
        'goal': _goal,
        'healthIssue': _healthIssue,
        // Add other fields if necessary
      });
      _errorMessage = '';
    } catch (e) {
      _errorMessage = "Failed to update user data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
