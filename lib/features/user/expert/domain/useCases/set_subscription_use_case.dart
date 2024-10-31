import 'package:azem/features/user/expert/domain/entities/subscription_entity.dart';
import 'package:azem/features/user/expert/domain/repositories/subscription_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';

class SetSubscriptionUseCase {
  final SubscriptionRepository repository;

  SetSubscriptionUseCase(this.repository);

  Future<Either<Failure, void>> call(SubscriptionEntity subscription) async {
    return await repository.setSubscription(subscription);
  }
}


