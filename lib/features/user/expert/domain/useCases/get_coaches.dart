import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/expert_entities.dart';
import '../repositories/expert_repositories.dart';

class GetCoachesUseCase {
  final ExpertRepository repository;

  GetCoachesUseCase(this.repository);

  Future<Either<Failure, List<ExpertEntity>>> execute() async {
    return await repository.getCoaches();
  }
}
