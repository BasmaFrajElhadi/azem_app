import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../entities/expert_entities.dart';
import '../repositories/expert_repositories.dart';  // Dartz package for Either type


class GetExpertsUseCase {
  final ExpertRepository repository;

  GetExpertsUseCase(this.repository);

  Future<Either<Failure, List<ExpertEntity>>> execute() async {
    return await repository.getExperts();
  }
}
