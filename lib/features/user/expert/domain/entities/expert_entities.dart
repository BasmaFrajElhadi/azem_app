class ExpertEntity {
  final String name;
  final String bio;
  final String role;
  final String imagePath;
  final int subscriptionPrice;
  final String email;
  final int loves;

  ExpertEntity({
    required this.name,
    required this.bio,
    required this.role,
    required this.imagePath,
    required this.subscriptionPrice,
    required this.email,
    this.loves = 0,
  });
}
