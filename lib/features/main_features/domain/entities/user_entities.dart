class UserEntities {
  final String email;
  final String password;
  final String name;
  final String role;
  final double weight;
  final double height;
  final String goal;
  final String birthDate;

  UserEntities({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.weight,
    required this.height,
    required this.goal,
    required this.birthDate,
  });
}

// ===========
// domain/entities/user.dart

class User {
  final String name;
  final String email;
  final String password;
  final String role;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

class Nutritionist extends User {
  final String bio;
  final String imagePath;
  final double subscriptionPrice;

  Nutritionist({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required this.bio,
    required this.imagePath,
    required this.subscriptionPrice,
  });
}

class Coach extends User {
  final String bio;
  final String imagePath;
  final double subscriptionPrice;

  Coach({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required this.bio,
    required this.imagePath,
    required this.subscriptionPrice,
  });
}

class RegularUser extends User {
  final double height;
  final double weight;
  final String birthDate;
  final String goal;
  final String healthIssues;

  RegularUser({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.goal,
    this.healthIssues = '',
  });
}

