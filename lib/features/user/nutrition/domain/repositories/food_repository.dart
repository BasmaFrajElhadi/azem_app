import 'package:azem/core/constants/strings/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/food_entity.dart';

abstract class FoodRepository{
  Future<Either<Failure, List<FoodEntity>>>  getFood();
  Future<Either<Failure, List<FoodEntity>>>   getFoodByCategory(String category);
}