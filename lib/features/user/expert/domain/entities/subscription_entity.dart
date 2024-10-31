class SubscriptionEntity {
  final String expertEmail;
  final String userEmail;
  final int price;
  final int duration;
  final String paymentMethod;
  final String status;

  SubscriptionEntity({
    required this.expertEmail,
    required this.userEmail,
    required this.price,
    required this.duration,
    required this.paymentMethod,
    required this.status,
  });
}
