import 'package:azem/core/constants/strings/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/daily_food_ration_entity.dart';

abstract class DailyFoodRationRepository{
  Future<Either<Failure, List<DailyFoodRationEntity>>>  getToDayFoodRation(int mealTime,DateTime todayDate,String userEmail);
  Future<Either<Failure, void>> setToDayFoodRation(DailyFoodRationEntity DailyFoodRation);
  Future<Either<Failure, void>> deleteToDayFoodRation(String dailyFoodRationId);
}