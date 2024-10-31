import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionByUser {
  final SubscriptionRepository repository;

  GetSubscriptionByUser(this.repository);

  Future<Either<Failure, List<SubscriptionEntity>>>  call(String expertUser) async {
    return await repository.getSubscriptionByUser(expertUser);
  }
}


