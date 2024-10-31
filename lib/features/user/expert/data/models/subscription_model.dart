
import '../../domain/entities/subscription_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  SubscriptionModel({
    required super.expertEmail,
    required super.userEmail,
    required super.price,
    required super.duration,
    required super.paymentMethod,
    required super.status,
  });

  // Factory constructor to create SubscriptionModel from JSON
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      expertEmail: json['expertEmail'] as String,
      userEmail: json['userEmail'] as String,
      price: (json['price'] as num).toInt(),
      duration: json['duration'] as int,
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
    );
  }

  // Method to convert SubscriptionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'expertEmail': expertEmail,
      'userEmail': userEmail,
      'price': price,
      'duration': duration,
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }
}
