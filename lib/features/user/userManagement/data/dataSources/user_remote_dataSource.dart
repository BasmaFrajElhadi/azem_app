import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, UserModel>> getUserById(int id);
  Future<Either<Failure, Unit>> addUser(UserModel user);
  Future<Either<Failure, Unit>> updateUser(UserModel user);
  Future<Either<Failure, Unit>> deleteUser(int id);
  Future<Either<Failure, List<UserModel>>> getAllUsers();
  Future<Either<Failure, UserModel>> getUserByEmail(String email);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, UserModel>> getUserById(int id) async {
    try {
      final doc = await firestore.collection('users').doc(id.toString()).get();
      if (doc.exists) {
        final userData = UserModel.fromFirebase(doc.data()!);
        return Right(userData);
      } else {
        return Left(Failure('User not found'));
      }
    } catch (e) {
      return Left(Failure('Failed to fetch user: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id.toString()).set(user.toFirebase());
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to add user: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id.toString()).update(user.toFirebase());
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to update user: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id) async {
    try {
      await firestore.collection('users').doc(id.toString()).delete();
      return const Right(unit);
    } catch (e) {
      return Left(Failure('Failed to delete user: $e'));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final querySnapshot = await firestore.collection('users').get();
      final users = querySnapshot.docs.map((doc) {
        return UserModel.fromFirebase(doc.data());
      }).toList();
      return Right(users);
    } catch (e) {
      return Left(Failure('Failed to fetch users: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserByEmail(String email) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = UserModel.fromFirebase(querySnapshot.docs.first.data());
        return Right(userData);
      } else {
        return Left(Failure('User not found'));
      }
    } catch (e) {
      return Left(Failure('Failed to fetch user by email: $e'));
    }
  }
}

