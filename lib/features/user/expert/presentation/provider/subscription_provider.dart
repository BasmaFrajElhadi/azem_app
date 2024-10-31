import 'package:flutter/material.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../../../userManagement/domain/repositories/user_repository.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/user_subscription.dart';
import '../../domain/repositories/subscription_repository.dart';

class SubscriptionProvider with ChangeNotifier {
  final SubscriptionRepository subscriptionRepository;
  final UserRepository userRepository;

  SubscriptionProvider({
    required this.subscriptionRepository,
    required this.userRepository,
  });

  List<SubscriptionEntity> _subscriptions = [];
  final List<UserSubscription> _usersInSubscription = []; // Updated to hold UserSubscription
  Failure? _failure;
  bool _isLoading = false;

  List<SubscriptionEntity> get subscriptions => _subscriptions;
  List<UserSubscription> get usersInSubscription => _usersInSubscription; // Getter updated
  Failure? get failure => _failure;
  bool get isLoading => _isLoading;

  // Fetch all subscriptions
  Future<void> fetchAllSubscriptions() async {
    _isLoading = true;
    notifyListeners();

    final result = await subscriptionRepository.getAllSubscription();
    result.fold(
          (failure) {
        _failure = failure;
      },
          (subscriptions) {
        _subscriptions = subscriptions;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSubscriptionsByExpert(String expertEmail) async {
    _isLoading = true;
    _usersInSubscription.clear();
    notifyListeners();

    final result = await subscriptionRepository.getSubscriptionByExpert(expertEmail);
    result.fold(
          (failure) {
        _failure = failure;
        print("Failed to fetch subscriptions: $failure"); // Debug print
      },
          (subscriptions) async {
        print("Subscriptions fetched: ${subscriptions.length}"); // Debug print
        _subscriptions = subscriptions;

        for (var subscription in _subscriptions) {
          final userResult = await userRepository.getUserByEmail(subscription.userEmail);
          userResult.fold(
                (failure) {
              _failure = failure;
              print("Failed to fetch user: $failure"); // Debug print
            },
                (user) {
              final userSubscription = UserSubscription(
                user: user,
                duration: subscription.duration,
                status: subscription.status,
              );
              _usersInSubscription.add(userSubscription);
              print("User added: ${user.email}"); // Debug print
                        },
          );
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  // Fetch subscriptions by user
  Future<void> fetchSubscriptionsByUser(String userEmail) async {
    _isLoading = true;
    notifyListeners();

    final result = await subscriptionRepository.getSubscriptionByUser(userEmail);
    result.fold(
          (failure) {
        _failure = failure;
      },
          (subscriptions) {
        _subscriptions = subscriptions;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  // Set a new subscription
  Future<void> addSubscription(SubscriptionEntity subscription) async {
    _isLoading = true;
    notifyListeners();

    final result = await subscriptionRepository.setSubscription(subscription);
    result.fold(
          (failure) {
        _failure = failure;
      },
          (_) {
        _subscriptions.add(subscription); // Add the subscription to the list
      },
    );

    _isLoading = false;
    notifyListeners();
  }


}
