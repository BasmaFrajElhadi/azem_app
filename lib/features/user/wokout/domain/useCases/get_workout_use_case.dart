import 'package:azem/features/user/wokout/domain/entities/workout_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../repositories/workout_repository.dart';

class GetWorkout{
  final WorkoutRepository repository;
  GetWorkout({required this.repository});
  Future<Either<Failure, List<WorkoutEntity>>> call(){
    return repository.getWorkout();
  }
}