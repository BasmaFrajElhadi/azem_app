import '../../domain/entities/expert_entities.dart';

class ExpertModel extends ExpertEntity {
  ExpertModel({
    required super.name,
    required super.bio,
    required super.role,
    required super.imagePath,
    required super.subscriptionPrice,
    required super.email,
    super.loves,
  });

  factory ExpertModel.fromFirebase(Map<String, dynamic> data) {
    return ExpertModel(
      name: data['name'] ?? 'No Name',
      bio: data['bio'] ?? 'No Bio',
      role: data['role'] ?? 'No Role',
      imagePath: data['imagePath'] ?? 'default_image.png',
      subscriptionPrice: data['subscriptionPrice'] ?? 0,
      email: data['email'] ?? 'no_email@example.com',
      loves: data['loves'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'role': role,
      'imagePath': imagePath,
      'subscriptionPrice': subscriptionPrice,
      'email': email,
      'loves': loves,
    };
  }
}
