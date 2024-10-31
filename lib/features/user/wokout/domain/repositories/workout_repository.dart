import 'package:azem/core/constants/strings/failure.dart';
import 'package:azem/features/user/wokout/domain/entities/workout_entity.dart';
import 'package:dartz/dartz.dart';


abstract class WorkoutRepository{
  Future<Either<Failure, List<WorkoutEntity>>>  getWorkout();
  Future<Either<Failure, List<WorkoutEntity>>>   getWorkoutByCategory(String category);
}