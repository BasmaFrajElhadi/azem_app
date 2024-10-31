import 'package:azem/features/user/wokout/domain/entities/workout_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutModel extends WorkoutEntity {
  WorkoutModel({
    required super.METValue,
    required super.workoutName,
    required super.typeOfWorkout,
    required super.imagePath,
  });

  factory WorkoutModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WorkoutModel(
      METValue: data['METValue'],
      workoutName: data['workoutName'],
      typeOfWorkout: data['typeOfWorkout'],
      imagePath: data['imagePath'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'METValue': METValue,
      'workoutName': workoutName,
      'typeOfWorkout': typeOfWorkout,
      'imagePath': imagePath,
    };
  }
}
