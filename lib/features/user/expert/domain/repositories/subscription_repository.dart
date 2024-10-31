import 'package:azem/features/user/expert/domain/entities/subscription_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';

abstract class SubscriptionRepository{
  // Fetch all Subscription
  Future<Either<Failure, List<SubscriptionEntity>>> getAllSubscription();

  // Fetch experts Subscription
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionByExpert(String expertEmail);

  // Fetch user Subscription
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionByUser(String userEmail);

  // set new Subscription
  Future<Either<Failure, void>> setSubscription(SubscriptionEntity subscription);
}
