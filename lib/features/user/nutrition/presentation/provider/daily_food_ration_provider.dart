import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/daily_food_ration_entity.dart';
import '../../domain/useCases/get_today_food_ration_use_case.dart';
import '../../domain/useCases/set_today_food_ration_use_case.dart';
import '../../domain/useCases/delete_today_food_ration_use_case.dart';

class DailyFoodRationProvider with ChangeNotifier {
  final GetTodayFoodRationUseCase getTodayFoodRationUseCase;
  final SetTodayFoodRationUseCase setTodayFoodRationUseCase;
  final DeleteTodayFoodRationUseCase deleteTodayFoodRationUseCase;
  late Future<Either<Failure, List<DailyFoodRationEntity>>> _dailyMealsData;
  DailyFoodRationProvider({
    required this.getTodayFoodRationUseCase,
    required this.setTodayFoodRationUseCase,
    required this.deleteTodayFoodRationUseCase,
  });

  List<DailyFoodRationEntity> _todayFoodRation = [];
  List<DailyFoodRationEntity> get todayFoodRation => _todayFoodRation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<Either<Failure, List<DailyFoodRationEntity>>> get dailyMealsData => _dailyMealsData;


  void updateDailyMealsData(int mealTime, DateTime todayDate, String userEmail) {
    _dailyMealsData = getTodayFoodRation(mealTime, todayDate, userEmail);
    notifyListeners();
  }

  // Fetch today's food ration data
  Future<Either<Failure, List<DailyFoodRationEntity>>> getTodayFoodRation(
      int mealTime, DateTime todayDate, String userEmail) async {
    _isLoading = true;
    _errorMessage = null;
    _todayFoodRation.clear();
    notifyListeners();

    try {
      final result = await getTodayFoodRationUseCase(mealTime, todayDate, userEmail);
      result.fold(
            (failure) => _errorMessage = _mapFailureToMessage(failure),
            (data) {
          _todayFoodRation = data;
        },
      );

      return result;
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      return Left(ServerFailure());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  String getMealNameById(int mealId) {
    switch (mealId) {
      case 1:
        return 'وجبة الفطور';
      case 2:
        return 'وجبة الغذاء';
      case 3:
        return 'وجبة العشاء';
      case 4:
        return 'وجبة خفيفة';
      default:
        return 'Unknown ID';
    }
  }

  double get totalCalories {
    double total = _todayFoodRation.fold(0, (sum, meal) => sum + (meal.calories ?? 0));
    return total == 0 ? 0 : total;
  }



  // Set new food ration data
  Future<void> setTodayFoodRation(DailyFoodRationEntity dailyFoodRation) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await setTodayFoodRationUseCase(dailyFoodRation);
      result.fold(
            (failure) {
          _errorMessage = _mapFailureToMessage(failure);
        },
            (_) {
          // Update the list after successfully adding the new ration
          _todayFoodRation.add(dailyFoodRation); // Add the new meal
          notifyListeners(); // Notify listeners to update the UI
        },
      );
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a specific food ration by document ID
  Future<void> deleteTodayFoodRation(String dailyFoodRationId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await deleteTodayFoodRationUseCase(dailyFoodRationId);
      result.fold(
            (failure) {
          _errorMessage = _mapFailureToMessage(failure);
        },
            (_) {
          // Remove the deleted item from the list
          _todayFoodRation.removeWhere((meal) => meal.id == dailyFoodRationId);
          notifyListeners(); // Notify listeners to update the UI
        },
      );
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Helper function to map failures to error messages
  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) return "No internet connection.";
    if (failure is ServerFailure) return "Server error. Please try again.";
    if (failure is NotFoundFailure) return "Data not found.";
    return "An unexpected error occurred.";
  }
}
