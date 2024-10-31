import 'package:azem/features/user/nutrition/data/models/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FoodFirebaseDataSource {
  final FirebaseFirestore firestore;

  FoodFirebaseDataSource(this.firestore);

  Future<FoodModel?> getAllFood() async {
    return null;
  

  }
}
