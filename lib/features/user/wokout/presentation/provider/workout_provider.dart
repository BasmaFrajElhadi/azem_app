import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/workout_entity.dart';
import '../../domain/useCases/get_workout_by_category_use_case.dart';
import '../../domain/useCases/get_workout_use_case.dart';

class WorkoutProvider with ChangeNotifier {
  final GetWorkout getWorkoutUseCase;
  final GetWorkoutByCategoryUseCase getWorkoutByCategoryUseCase;

  WorkoutProvider({
    required this.getWorkoutUseCase,
    required this.getWorkoutByCategoryUseCase,
  });

  List<WorkoutEntity> _workouts = [];
  List<WorkoutEntity> get workouts => _workouts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch all workouts
  Future<Either<Failure, List<WorkoutEntity>>> fetchAllWorkouts() async {
    _isLoading = true;
    _errorMessage = null;
    _workouts.clear();
    notifyListeners();

    try {
      final result = await getWorkoutUseCase();
      result.fold(
            (failure) => _errorMessage = _mapFailureToMessage(failure),
            (data) => _workouts = data,
      );
      return result; // Return the result directly
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      return Left(ServerFailure()); // Return ServerFailure in case of an exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch workouts by category
  Future<Either<Failure, List<WorkoutEntity>>> fetchWorkoutsByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    _workouts.clear();
    notifyListeners();

    try {
      final result = await getWorkoutByCategoryUseCase(category);
      result.fold(
            (failure) => _errorMessage = _mapFailureToMessage(failure),
            (data) => _workouts = data,
      );
      return result; // Return the result directly
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      return Left(ServerFailure()); // Return ServerFailure in case of an exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper function to map failures to error messages
  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) return "No internet connection.";
    if (failure is ServerFailure) return "Server error. Please try again.";
    if (failure is NotFoundFailure) return "No workouts found.";
    return "An unexpected error occurred.";
  }
}
