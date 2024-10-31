import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/user_entities.dart';
import '../dataSources/user_remote_dataSource.dart';
import '../models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity?>> getUserById(int id) async {
    final result = await remoteDataSource.getUserById(id);
    return result.fold(
          (failure) => Left(failure),
          (userModel) => Right(userModel as UserEntity?),
    );
  }

  @override
  Future<Either<Failure, Unit>> addUser(UserEntity user) {
    return remoteDataSource.addUser(user as UserModel);
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity user) {
    return remoteDataSource.updateUser(user as UserModel);
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id) {
    return remoteDataSource.deleteUser(id);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    final either = await remoteDataSource.getAllUsers();
    return either.fold(
          (failure) => Left(failure),
          (userModels) => Right(userModels.cast<UserEntity>()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserByEmail(String email) async {
    final result = await remoteDataSource.getUserByEmail(email);
    return result.fold(
          (failure) => Left(failure),
          (userModel) => Right(userModel as UserEntity), // Cast UserModel to UserEntity
    );
  }
}
