import 'package:azem/core/constants/strings/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/networkInfo.dart';
import '../../domain/entities/daily_food_ration_entity.dart';
import '../../domain/repositories/daily_food_ration_repository.dart';

class DailyFoodRationRepositoryImp implements DailyFoodRationRepository {
  final FirebaseFirestore firestore;
  final NetworkInfo networkInfo;

  DailyFoodRationRepositoryImp(this.firestore, this.networkInfo);

  @override
  Future<Either<Failure, List<DailyFoodRationEntity>>> getToDayFoodRation(
      int mealTime, DateTime todayDate, String userEmail) async {
    if (await networkInfo.isConnected) {
      try {

        final snapshot = await firestore
            .collection('dailyFoodRation')
            .where('mealTimes', isEqualTo: mealTime)
            .where('userEmail', isEqualTo: userEmail)
            .where('date', isEqualTo: todayDate) // Start of the day
            .get();

        // If no documents are found, return a NotFoundFailure
        if (snapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        // Map each document to a DailyFoodRationEntity
        final foodList = snapshot.docs
            .map((doc) => DailyFoodRationEntity.fromFirestore(doc))
            .toList();

        // Return the list wrapped in a Right to indicate success
        return Right(foodList);
      } on FirebaseException {
        // Firebase-specific error handling
        return Left(ServerFailure());
      } catch (_) {
        // Network or other unexpected error
        return Left(NetworkFailure());
      }
    } else {
      // No internet connection
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setToDayFoodRation(DailyFoodRationEntity dailyFoodRation) async {
    if (await networkInfo.isConnected) {
      try {
        // Prepare the meal data with correct date format
        final mealData = {
          'userEmail': dailyFoodRation.userEmail,
          'foodName': dailyFoodRation.foodName,
          'calories': dailyFoodRation.calories,
          'imagePath': dailyFoodRation.imagePath,
          'carbs': dailyFoodRation.carbs,
          'fat': dailyFoodRation.fat,
          'fiber': dailyFoodRation.fiber,
          'protein': dailyFoodRation.protein,
          'sodium': dailyFoodRation.sodium,
          'date': Timestamp.fromDate(dailyFoodRation.date),
          'mealTimes': dailyFoodRation.mealTimes,
          'amount': dailyFoodRation.amount,
          'size': dailyFoodRation.size,
        };

        // Log data for debugging
        print("Saving meal data: $mealData");

        // Add the meal data to Firestore
        await firestore.collection('dailyFoodRation').add(mealData);

        return const Right(null); // Indicate success
      } on FirebaseException catch (e) {
        print("Firebase exception: $e");
        return Left(ServerFailure());
      } catch (e) {
        print("Unexpected error: $e");
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  // Delete method to remove a specific document
  @override
  Future<Either<Failure, void>> deleteToDayFoodRation(String dailyFoodRationId) async {
    if (await networkInfo.isConnected) {
      try {
        await firestore.collection('dailyFoodRation').doc(dailyFoodRationId).delete();
        return const Right(null); // Indicate success
      } on FirebaseException catch (e) {
        print("Firebase exception: $e");
        return Left(ServerFailure());
      } catch (e) {
        print("Unexpected error: $e");
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
