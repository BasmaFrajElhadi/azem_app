class FoodEntity{
  final String foodName;
  final String foodType;
  final String defaultUnit;
  final String imagePath;
  final int caloriesPerUnit;
  final int carbs;
  final int fat;
  final int fiber;
  final int protein;
  final int sodium;

  FoodEntity({
    required this.foodName,
    required this.foodType,
    required this.defaultUnit,
    required this.imagePath,
    required this.caloriesPerUnit,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.protein,
    required this.sodium,
});
}