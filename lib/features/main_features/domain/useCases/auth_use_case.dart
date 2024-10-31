// domain/usecases/auth_usecase.dart



import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpUseCase {
  Future<void> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime birthdate,
    required String height,
    required String weight,
    required String goal,
    required String healthIssue,
  }) async {
    final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'birthdate': birthdate,
      'height': height,
      'weight': weight,
      'goal': goal,
      'healthIssue' : healthIssue
    });
  }
}


class LoginUseCase {
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential; // Return the user credential
    } on FirebaseAuthException catch (e) {
      // Handle different types of authentication exceptions
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Login failed. Please try again later.');
      }
    }
  }
}

// abstract class AuthUseCase {
//   Future<void> signUp(User user);
//   Future<User> login(String email, String password);
//   Future<void> logout();
// }
//
// // domain/usecases/nutritionist_usecase.dart
//
// abstract class NutritionistUseCase {
//   Future<void> addNutritionist(Nutritionist nutritionist);
// }
//
// abstract class CoachUseCase {
//   Future<void> addCoach(Nutritionist nutritionist);
// }
//
// // domain/usecases/user_usecase.dart
//
// abstract class UserUseCase {
//   Future<void> addUser(RegularUser user);
// }
