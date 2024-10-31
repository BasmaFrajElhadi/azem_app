import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity?>> getUserById(int id);
  Future<Either<Failure, Unit>> addUser(UserEntity user);
  Future<Either<Failure, Unit>> updateUser(UserEntity user);
  Future<Either<Failure, Unit>> deleteUser(int id);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, UserEntity>> getUserByEmail(String email);

}
