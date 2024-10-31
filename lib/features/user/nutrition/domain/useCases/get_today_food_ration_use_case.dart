import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/daily_food_ration_entity.dart';
import '../repositories/daily_food_ration_repository.dart';

class GetTodayFoodRationUseCase {
  final DailyFoodRationRepository repository;

  GetTodayFoodRationUseCase(this.repository);

  Future<Either<Failure, List<DailyFoodRationEntity>>>   call(int mealTime,DateTime todayDate,String userEmail) async {
    return await repository.getToDayFoodRation(mealTime,todayDate, userEmail);
  }
}


