import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/connection/networkInfo.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../models/subscription_model.dart';

class SubscriptionRepositoryImp implements SubscriptionRepository {
  final FirebaseFirestore firestore;
  final NetworkInfo networkInfo;

  SubscriptionRepositoryImp(this.firestore, this.networkInfo);

  final String _subscriptionCollection = 'subscription';

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getAllSubscription() async {
    if (await networkInfo.isConnected) {
      try {
        final querySnapshot = await firestore.collection(_subscriptionCollection).get();

        if (querySnapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final subscriptions = querySnapshot.docs
            .map((doc) => SubscriptionModel.fromJson(doc.data()))
            .toList();

        return Right(subscriptions);
      } on FirebaseException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionByExpert(String expertEmail) async {
    if (await networkInfo.isConnected) {
      try {
        final querySnapshot = await firestore
            .collection(_subscriptionCollection)
            .where('expertEmail', isEqualTo: expertEmail)
            .get();

        if (querySnapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final subscriptions = querySnapshot.docs
            .map((doc) => SubscriptionModel.fromJson(doc.data()))
            .toList();

        return Right(subscriptions);
      } on FirebaseException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionByUser(String userEmail) async {
    if (await networkInfo.isConnected) {
      try {
        final querySnapshot = await firestore
            .collection(_subscriptionCollection)
            .where('userEmail', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isEmpty) {
          return Left(NotFoundFailure());
        }

        final subscriptions = querySnapshot.docs
            .map((doc) => SubscriptionModel.fromJson(doc.data()))
            .toList();

        return Right(subscriptions);
      } on FirebaseException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setSubscription(SubscriptionEntity subscription) async {
    if (await networkInfo.isConnected) {
      try {
        final subscriptionModel = SubscriptionModel(
          expertEmail: subscription.expertEmail,
          userEmail: subscription.userEmail,
          price: subscription.price,
          duration: subscription.duration,
          paymentMethod: subscription.paymentMethod,
          status: subscription.status,
        );

        await firestore.collection(_subscriptionCollection).add(subscriptionModel.toJson());

        return const Right(null);
      } on FirebaseException catch (e) {
        print("Firebase exception: $e");
        return Left(ServerFailure());
      } catch (e) {
        print("Unexpected error: $e");
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, void>> deleteSubscription(String subscriptionId) async {
    if (await networkInfo.isConnected) {
      try {
        await firestore.collection(_subscriptionCollection).doc(subscriptionId).delete();
        return const Right(null);
      } on FirebaseException catch (e) {
        print("Firebase exception: $e");
        return Left(ServerFailure());
      } catch (e) {
        print("Unexpected error: $e");
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
