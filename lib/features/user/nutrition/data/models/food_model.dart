import 'package:azem/features/user/nutrition/domain/entities/food_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel extends FoodEntity{
  FoodModel({
    required super.foodName,
    required super.foodType,
    required super.defaultUnit,
    required super.imagePath,
    required super.caloriesPerUnit,
    required super.carbs,
    required super.fat,
    required super.fiber,
    required super.protein,
    required super.sodium,
  });

  factory FoodModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FoodModel(
      foodName: data['foodName'],
      foodType: data['foodType'],
      defaultUnit: data['defaultUnit'],
      imagePath: data['imagePath'],
      caloriesPerUnit: data['caloriesPerUnit'],
      carbs: data['carbs'],
      fat: data['fat'],
      fiber: data['fiber'],
      protein: data['protein'],
      sodium: data['sodium'],
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      'foodName': foodName,
      'foodType': foodType,
      'defaultUnit': defaultUnit,
      'imagePath': imagePath,
      'caloriesPerUnit': caloriesPerUnit,
      'carbs':carbs,
      'fat' : fat,
      'fiber' : fiber,
      'protein': protein,
      'sodium' : sodium,
    };
  }

}