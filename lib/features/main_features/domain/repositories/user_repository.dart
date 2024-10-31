// domain/repositories/user_repository.dart

import '../entities/user_entities.dart';

// abstract class UserRepository {
//   Future<UserEntities?> login(String email, String password);
// }
//===========
// domain/repositories/auth_repository.dart


abstract class AuthRepository {
  Future<void> signUp(User user);
  Future<User> login(String email, String password);
  Future<void> logout();
}

// domain/repositories/nutritionist_repository.dart


abstract class NutritionistRepository {
  Future<void> addNutritionist(Nutritionist nutritionist);
}

abstract class CoachUseCase {
  Future<void> addCoach(Nutritionist nutritionist);
}

// domain/repositories/user_repository.dart

abstract class UserRepository {
  Future<void> addUser(RegularUser user);
}
