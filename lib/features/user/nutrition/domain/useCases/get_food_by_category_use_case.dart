import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/food_entity.dart';
import '../repositories/food_repository.dart';

class GetFoodByCategoryUseCase {
  final FoodRepository repository;

  GetFoodByCategoryUseCase(this.repository);

  Future<Either<Failure, List<FoodEntity>>>   call(String category) async {
    return await repository.getFoodByCategory(category);
  }
}


