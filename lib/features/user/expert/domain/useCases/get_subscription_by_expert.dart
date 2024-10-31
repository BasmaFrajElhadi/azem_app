import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionByExpert {
  final SubscriptionRepository repository;

  GetSubscriptionByExpert(this.repository);

  Future<Either<Failure, List<SubscriptionEntity>>>  call(String expertEmail) async {
    return await repository.getSubscriptionByExpert(expertEmail);
  }
}


