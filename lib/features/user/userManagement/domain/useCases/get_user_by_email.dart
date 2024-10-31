import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/user_entities.dart';
import '../repositories/user_repository.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);
  Future<Either<Failure, UserEntity?>> call(String email) {
    return repository.getUserByEmail(email);
  }
}
