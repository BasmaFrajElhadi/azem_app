import 'package:azem/features/user/wokout/domain/entities/workout_entity.dart';
import 'package:azem/features/user/wokout/domain/repositories/workout_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';

class GetWorkoutByCategoryUseCase {
  final WorkoutRepository repository;

  GetWorkoutByCategoryUseCase(this.repository);

  Future<Either<Failure, List<WorkoutEntity>>>   call(String category) async {
    return await repository.getWorkoutByCategory(category);
  }
}


