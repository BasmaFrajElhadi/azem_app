import 'package:azem/features/user/nutrition/domain/entities/daily_food_ration_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyFoodRationModel extends DailyFoodRationEntity{
  DailyFoodRationModel({
    super.id,
    required super.userEmail,
    required super.foodName,
    required super.imagePath,
    required super.calories,
    required super.carbs,
    required super.fat,
    required super.fiber,
    required super.protein,
    required super.sodium,
    required super.date,
    required super.mealTimes,
    required super.amount,
    required super.size,

  });

  factory DailyFoodRationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DailyFoodRationModel(
      id:data['id'],
      userEmail : data['userEmail'],
      foodName: data['foodName'],
      imagePath: data['imagePath'],
      calories: data['calories'],
      carbs: data['carbs'],
      fat: data['fat'],
      fiber: data['fiber'],
      protein: data['protein'],
      sodium: data['sodium'],
      date : data['date'],
      mealTimes:data['mealTimes'],
      amount : data['amount'],
      size:data['size']
    );
  }

}