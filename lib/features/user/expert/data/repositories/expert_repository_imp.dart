import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/expert_entities.dart';
import '../../domain/repositories/expert_repositories.dart';
import '../models/expert_model.dart';

class ExpertRepositoryImpl implements ExpertRepository {
  final FirebaseFirestore firestore;

  ExpertRepositoryImpl(this.firestore);

  // Fetch all experts (both coaches and nutritionists)
  @override
  Future<Either<Failure, List<ExpertEntity>>> getExperts() async {
    try {
      final querySnapshot = await firestore
          .collection('Users')
          .where('role', whereIn: ['coach', 'nutritionist'])
          .get();

      final experts = querySnapshot.docs
          .map((doc) => ExpertModel.fromFirebase(doc.data()))
          .toList();

      return Right(experts);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // Fetch only coaches
  @override
  Future<Either<Failure, List<ExpertEntity>>> getCoaches() async {
    try {
      final querySnapshot = await firestore
          .collection('Users')
          .where('role', isEqualTo: 'coach')
          .get();

      final coaches = querySnapshot.docs
          .map((doc) => ExpertModel.fromFirebase(doc.data()))
          .toList();

      return Right(coaches);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // Fetch only nutritionists
  @override
  Future<Either<Failure, List<ExpertEntity>>> getNutritionists() async {
    try {
      final querySnapshot = await firestore
          .collection('Users')
          .where('role', isEqualTo: 'nutritionist')
          .get();

      final nutritionists = querySnapshot.docs
          .map((doc) => ExpertModel.fromFirebase(doc.data()))
          .toList();

      return Right(nutritionists);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
