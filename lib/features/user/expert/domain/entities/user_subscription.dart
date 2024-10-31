import '../../../userManagement/domain/entities/user_entities.dart';

class UserSubscription {
  final UserEntity user;
  final int duration; // Assuming duration is a String, change to appropriate type
  final String status; // Assuming status is a String, change to appropriate type

  UserSubscription({
    required this.user,
    required this.duration,
    required this.status,
  });
}
