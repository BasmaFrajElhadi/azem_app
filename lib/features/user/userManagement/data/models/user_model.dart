import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String password;
  final DateTime birthDate; // Ensure this is of type DateTime
  final double weight; // Change to double for proper representation
  final double height; // Change to double for proper representation
  final String bio;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.bio,
    required this.role,
  });

  // Factory constructor to create a UserModel object from Firebase data
  factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
      id: data['ID'] as int,
      name: data['Name'] as String,
      email: data['Email'] as String,
      password: data['Password'] as String,
      birthDate: DateTime.parse(data['BirthDate'] as String), // Parse the date
      weight: (data['Weight'] as num).toDouble(), // Convert to double
      height: (data['Height'] as num).toDouble(), // Convert to double
      bio: data['Bio'] as String,
      role: data['Role'] as String,
    );
  }

  // Method to convert UserModel to Firebase-compatible Map
  Map<String, dynamic> toFirebase() {
    return {
      'ID': id,
      'Name': name,
      'Email': email,
      'Password': password,
      'BirthDate': '${birthDate.year},${birthDate.month},${birthDate.day}', // Store as string
      'Weight': weight,
      'Height': height,
      'Bio': bio,
      'Role': role,
    };
  }

  @override
  List<Object?> get props => [id, name, email, password, birthDate, weight, height, bio, role];
}
