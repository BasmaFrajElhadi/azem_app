import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/expert_entities.dart';

abstract class ExpertRepository {
  // Fetch all experts (coaches and nutritionists)
  Future<Either<Failure, List<ExpertEntity>>> getExperts();

  // Fetch only coaches
  Future<Either<Failure, List<ExpertEntity>>> getCoaches();

  // Fetch only nutritionists
  Future<Either<Failure, List<ExpertEntity>>> getNutritionists();
}
