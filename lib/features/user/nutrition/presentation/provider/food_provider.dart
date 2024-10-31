import 'package:flutter/material.dart';

import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/useCases/get_food_by_category_use_case.dart';


class FoodProvider with ChangeNotifier {
  final GetFoodByCategoryUseCase getFoodByCategoryUseCase;
  List<FoodEntity> foods = [];
  bool isLoading = false;
  Failure? error;

  FoodProvider(this.getFoodByCategoryUseCase);

  Future<void> fetchFoodsByCategory(String category) async {
    isLoading = true;
    notifyListeners();

    final result = await getFoodByCategoryUseCase(category);

    result.fold(
          (failure) {
        error = failure;
        foods = [];
      },
          (foodList) {
        error = null;
        foods = foodList;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
