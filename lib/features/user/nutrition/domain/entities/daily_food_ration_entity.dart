import 'package:cloud_firestore/cloud_firestore.dart';

class DailyFoodRationEntity {
  final String? id;
  final String userEmail;
  final String foodName;
  final String imagePath;
  final double calories;
  final double carbs;
  final double fat;
  final double fiber;
  final double protein;
  final double sodium;
  final DateTime date;
  final int mealTimes;
  final int amount;
  final String size;

  DailyFoodRationEntity({
    this.id,
    required this.userEmail,
    required this.foodName,
    required this.imagePath,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.protein,
    required this.sodium,
    required this.date,
    required this.mealTimes,
    required this.amount,
    required this.size,
  });

  // Factory constructor to create an instance from Firestore data
  factory DailyFoodRationEntity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DailyFoodRationEntity(
      id: doc.id,
      userEmail: data['userEmail'] ?? '',
      foodName: data['foodName'] ?? '',
      imagePath: data['imagePath'] ?? '',
      calories: (data['calories'] ?? 0).toDouble(),
      carbs: (data['carbs'] ?? 0).toDouble(),
      fat: (data['fat'] ?? 0).toDouble(),
      fiber: (data['fiber'] ?? 0).toDouble(),
      protein: (data['protein'] ?? 0).toDouble(),
      sodium: (data['sodium'] ?? 0).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      mealTimes: data['mealTimes'] ?? 0,
      amount: data['amount'] ?? 0,
      size: data['size'] ?? '',
    );
  }
}
