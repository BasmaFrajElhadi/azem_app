import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/daily_food_ration_entity.dart';
import '../repositories/daily_food_ration_repository.dart';

class SetTodayFoodRationUseCase {
  final DailyFoodRationRepository repository;

  SetTodayFoodRationUseCase(this.repository);

  Future<Either<Failure, void>> call(DailyFoodRationEntity DailyFoodRation) async {
    return await repository.setToDayFoodRation(DailyFoodRation);
  }
}


