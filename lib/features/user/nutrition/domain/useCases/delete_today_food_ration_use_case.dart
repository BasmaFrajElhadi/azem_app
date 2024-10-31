import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../repositories/daily_food_ration_repository.dart';

class DeleteTodayFoodRationUseCase {
  final DailyFoodRationRepository repository;

  DeleteTodayFoodRationUseCase(this.repository);

  Future<Either<Failure, void>> call(String dailyFoodRationId) async {
    return await repository.deleteToDayFoodRation(dailyFoodRationId);
  }
}


