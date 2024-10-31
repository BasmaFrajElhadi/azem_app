// import 'package:flutter/material.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../../core/constants/strings/failure.dart';
//
//
// class SubscriptionProvider with ChangeNotifier {
//   final SubscriptionRepository subscriptionRepository;
//
//   SubscriptionProvider({required this.subscriptionRepository});
//
//   List<SubscriptionEntity> _subscriptions = [];
//   Failure? _failure;
//   bool _isLoading = false;
//
//   List<SubscriptionEntity> get subscriptions => _subscriptions;
//   Failure? get failure => _failure;
//   bool get isLoading => _isLoading;
//
//   // Fetch all subscriptions
//   Future<void> fetchAllSubscriptions() async {
//     _isLoading = true;
//     notifyListeners();
//
//     final result = await subscriptionRepository.getAllSubscription();
//     result.fold(
//           (failure) {
//         _failure = failure;
//       },
//           (subscriptions) {
//         _subscriptions = subscriptions;
//       },
//     );
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   // Fetch subscriptions by expert
//   Future<void> fetchSubscriptionsByExpert(String expertEmail) async {
//     _isLoading = true;
//     notifyListeners();
//
//     final result = await subscriptionRepository.getSubscriptionByExpert(expertEmail);
//     result.fold(
//           (failure) {
//         _failure = failure;
//       },
//           (subscriptions) {
//         _subscriptions = subscriptions;
//       },
//     );
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   // Fetch subscriptions by user
//   Future<void> fetchSubscriptionsByUser(String userEmail) async {
//     _isLoading = true;
//     notifyListeners();
//
//     final result = await subscriptionRepository.getSubscriptionByUser(userEmail);
//     result.fold(
//           (failure) {
//         _failure = failure;
//       },
//           (subscriptions) {
//         _subscriptions = subscriptions;
//       },
//     );
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   // Set a new subscription
//   Future<void> addSubscription(SubscriptionEntity subscription) async {
//     _isLoading = true;
//     notifyListeners();
//
//     final result = await subscriptionRepository.setSubscription(subscription);
//     result.fold(
//           (failure) {
//         _failure = failure;
//       },
//           (_) {
//         _subscriptions.add(subscription); // Add the subscription to the list
//       },
//     );
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }
