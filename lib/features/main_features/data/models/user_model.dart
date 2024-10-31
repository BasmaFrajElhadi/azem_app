//
//
// import '../../domain/entities/user_entities.dart';
//
// class UserModel extends UserEntities {
//   UserModel({
//     required String email,
//     required String password,
//     required String name,
//     required String role,
//     required double weight,
//     required double height,
//     required String goal,
//     required String birthDate,
//   }) : super(
//     email: email,
//     password: password,
//     name: name,
//     role: role,
//     weight: weight,
//     height: height,
//     goal: goal,
//     birthDate: birthDate,
//   );
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       email: json['email'],
//       password: json['password'],
//       name: json['name'],
//       role: json['role'],
//       weight: json['weight'],
//       height: json['height'],
//       goal: json['goal'],
//       birthDate: json['birthDate'],
//     );
//   }
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'password': password,
//       'name': name,
//       'role': role,
//       'weight': weight,
//       'height': height,
//       'goal': goal,
//       'birthDate': birthDate,
//     };
//   }
// }

// data/models/user_model.dart

import '../../domain/entities/user_entities.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }
}

class NutritionistModel extends Nutritionist {
  NutritionistModel({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required super.bio,
    required super.imagePath,
    required super.subscriptionPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'bio': bio,
      'imagePath': imagePath,
      'subscriptionPrice': subscriptionPrice,
    };
  }

  factory NutritionistModel.fromJson(Map<String, dynamic> json) {
    return NutritionistModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      bio: json['bio'],
      imagePath: json['imagePath'],
      subscriptionPrice: json['subscriptionPrice'],
    );
  }
}

class RegularUserModel extends RegularUser {
  RegularUserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required super.height,
    required super.weight,
    required super.birthDate,
    required super.goal,
    super.healthIssues,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'goal': goal,
      'healthIssues': healthIssues,
    };
  }

  factory RegularUserModel.fromJson(Map<String, dynamic> json) {
    return RegularUserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      height: json['height'],
      weight: json['weight'],
      birthDate: json['birthDate'],
      goal: json['goal'],
      healthIssues: json['healthIssues'],
    );
  }
}

