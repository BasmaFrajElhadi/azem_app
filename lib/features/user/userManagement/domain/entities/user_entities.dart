import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;              // Represents 'ID' from Firebase (number)
  final String name;          // Represents 'Name' (string)
  final String email;         // Represents 'Email' (string)
  final String password;      // Represents 'Password' (string)
  final DateTime birthDate;   // Represents 'BirthDate' (string, parsed to DateTime)
  final int weight;           // Represents 'weight' (number)
  final int height;           // Represents 'height' (number)
  final String bio;           // Represents 'bio' (string)
  final String role;          // Represents 'role' (string)

  const UserEntity({
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

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    password,
    birthDate,
    weight,
    height,
    bio,
    role,
  ];

  factory UserEntity.fromFirebase(Map<String, dynamic> data) {
    return UserEntity(
      id: data['ID'] as int,
      name: data['Name'] as String,
      email: data['Email'] as String,
      password: data['Password'] as String,
      birthDate: DateTime.parse(data['BirthDate']), // Parse string to DateTime
      weight: data['weight'] as int,
      height: data['height'] as int,
      bio: data['bio'] as String,
      role: data['role'] as String,
    );
  }
}
