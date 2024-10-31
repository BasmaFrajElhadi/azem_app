import 'package:azem/features/user/nutrition/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/food_entity.dart';

class GetFood{
  final FoodRepository repository;
  GetFood({required this.repository});
  Future<Either<Failure, List<FoodEntity>>> call(){
    return repository.getFood();
  }
}