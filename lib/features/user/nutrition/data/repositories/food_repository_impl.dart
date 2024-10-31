import 'package:azem/core/constants/strings/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/networkInfo.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/repositories/food_repository.dart';
import '../models/food_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FirebaseFirestore firestore;
  final NetworkInfo networkInfo;

  FoodRepositoryImpl(this.firestore, this.networkInfo);

  @override
  Future<Either<Failure, List<FoodEntity>>> getFood() async {
    if (await networkInfo.isConnected) {
      try {
        final snapshot = await firestore.collection('foods').get();

        // If no documents are found, return a NotFoundFailure.
        if (snapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final foodList = snapshot.docs.map((doc) => FoodModel.fromFirestore(doc)).toList();
        return Right(foodList);
      } on FirebaseException {
        // Firebase-specific error handling
        return Left(ServerFailure());
      } catch (_) {
        return Left(NetworkFailure());
      }
    } else {
      // No internet connection
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getFoodByCategory(String category) async {
    if (await networkInfo.isConnected) {
      try {
        final snapshot = await firestore
            .collection('foods')
            .where('foodType', isEqualTo: category)
            .get();

        // Handle case where category has no items
        if (snapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final foodList = snapshot.docs.map((doc) => FoodModel.fromFirestore(doc)).toList();
        return Right(foodList);
      } on FirebaseException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(NetworkFailure());
      }
    } else {
      // No internet connection
      return Left(NetworkFailure());
    }
  }
}
