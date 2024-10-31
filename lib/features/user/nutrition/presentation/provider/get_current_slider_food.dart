import 'package:flutter/material.dart';


class GetCurrentSliderFoodProvider with ChangeNotifier {
  Map<String, dynamic>? _currentMeal;

  Map<String, dynamic>? get currentMeal => _currentMeal;

  void setCurrentMeal(Map<String, dynamic> meal) {
    _currentMeal = meal;
    notifyListeners();
  }
}


