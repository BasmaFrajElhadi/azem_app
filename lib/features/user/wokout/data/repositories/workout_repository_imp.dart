import 'package:azem/core/constants/strings/failure.dart';
import 'package:azem/features/user/wokout/data/models/workout_model.dart';
import 'package:azem/features/user/wokout/domain/entities/workout_entity.dart';
import 'package:azem/features/user/wokout/domain/repositories/workout_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/connection/networkInfo.dart';

class WorkoutRepositoryImp implements WorkoutRepository {
  final FirebaseFirestore firestore;
  final NetworkInfo networkInfo;

  WorkoutRepositoryImp(this.firestore, this.networkInfo);

  @override
  Future<Either<Failure, List<WorkoutEntity>>>  getWorkout() async {
    if (await networkInfo.isConnected) {
      try {
        final snapshot = await firestore.collection('workout').get();

        // If no documents are found, return a NotFoundFailure.
        if (snapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final foodList = snapshot.docs.map((doc) => WorkoutModel.fromFirestore(doc)).toList();
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
  Future<Either<Failure, List<WorkoutEntity>>>   getWorkoutByCategory(String category) async {
    if (await networkInfo.isConnected) {
      try {
        final snapshot = await firestore
            .collection('workout')
            .where('typeOfWorkout', isEqualTo: category)
            .get();

        // Handle case where category has no items
        if (snapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final foodList = snapshot.docs.map((doc) => WorkoutModel.fromFirestore(doc)).toList();
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
