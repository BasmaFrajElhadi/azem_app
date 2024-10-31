import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/expert_entities.dart';
import '../../domain/useCases/get_coaches.dart';
import '../../domain/useCases/get_experts.dart';
import '../../domain/useCases/get_nutritionists.dart';

class ExpertProvider with ChangeNotifier {
  final GetExpertsUseCase getExpertsUseCase;
  final GetCoachesUseCase getCoachesUseCase;
  final GetNutritionistsUseCase getNutritionistsUseCase;

  ExpertProvider({
    required this.getExpertsUseCase,
    required this.getCoachesUseCase,
    required this.getNutritionistsUseCase,
  });

  List<ExpertEntity> _experts = [];
  List<ExpertEntity> get experts => _experts;

  List<ExpertEntity> _coaches = [];
  List<ExpertEntity> get coaches => _coaches;

  List<ExpertEntity> _nutritionists = [];
  List<ExpertEntity> get nutritionists => _nutritionists;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch all experts (coaches and nutritionists)
  Future<void> fetchExperts() async {
    _setLoading(true);
    final Either<Failure, List<ExpertEntity>> result = await getExpertsUseCase.execute();
    result.fold(
          (failure) {
        _errorMessage = failure.message;
        _experts = [];
      },
          (experts) {
        _experts = experts;
        _errorMessage = null;
      },
    );
    _setLoading(false);
  }

  // Fetch only coaches
  Future<void> fetchCoaches() async {
    _setLoading(true);
    final Either<Failure, List<ExpertEntity>> result = await getCoachesUseCase.execute();
    result.fold(
          (failure) {
        _errorMessage = failure.message;
        _coaches = [];
      },
          (coaches) {
        _coaches = coaches;
        _errorMessage = null;
      },
    );
    _setLoading(false);
  }

  // Fetch only nutritionists
  Future<void> fetchNutritionists() async {
    _setLoading(true);
    final Either<Failure, List<ExpertEntity>> result = await getNutritionistsUseCase.execute();
    result.fold(
          (failure) {
        _errorMessage = failure.message;
        _nutritionists = [];
      },
          (nutritionists) {
        _nutritionists = nutritionists;
        _errorMessage = null;
      },
    );
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
