import 'package:azem/features/user/expert/domain/entities/subscription_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../repositories/subscription_repository.dart';

class GetAllSubscriptionUseCase{
  final SubscriptionRepository repository;
  GetAllSubscriptionUseCase({required this.repository});
  Future<Either<Failure, List<SubscriptionEntity>>> call(){
    return repository.getAllSubscription();
  }
}