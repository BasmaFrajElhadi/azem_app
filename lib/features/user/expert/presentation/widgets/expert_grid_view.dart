import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../pages/expert_profile_screen.dart';

class ExpertCard extends StatefulWidget {
  final String email;
  final String imagePath;
  final String name;
  final String bio;
  final String role;
  final int subscriptionPrice;
  final int loves;

  const ExpertCard({
    super.key,
    required this.email,
    required this.imagePath,
    required this.name,
    required this.bio,
    required this.role,
    required this.loves,
    required this.subscriptionPrice,
  });

  @override
  _ExpertCardState createState() => _ExpertCardState();
}

class _ExpertCardState extends State<ExpertCard> {
  late bool isLiked;
  late int currentLoves;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    currentLoves = widget.loves;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      currentLoves += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertProfileScreen(
              name: widget.name,
              email: widget.email,
              imagePath: widget.imagePath,
              role: widget.role,
              bio: widget.bio,
              likes: currentLoves,
              subscriptionPrice: widget.subscriptionPrice,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 180,
        height: 320,
        child: Container(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: AppSizes.fontSizeMd,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.role,
                                style: const TextStyle(
                                  fontSize: AppSizes.fontSizeXs,
                                  color: AppColors.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: toggleLike,
                          child: Column(
                            children: [
                              // Change heart icon based on like status
                              Image.asset(
                                isLiked
                                    ? IconsPath.filledFavoriteIcon
                                    : IconsPath.favoriteIcon,
                                height: AppSizes.iconMd,
                              ),
                              Text(
                                currentLoves.toString(),
                                style: const TextStyle(
                                  fontSize: AppSizes.fontSizeXs,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpertGridView extends StatelessWidget {
  final List<Map<String, dynamic>> expertList;

  const ExpertGridView({super.key, required this.expertList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.55,
      ),
      itemCount: expertList.length,
      itemBuilder: (context, index) {
        final expert = expertList[index];
        return ExpertCard(
          email:expert['email']??"",
          imagePath: expert['imagePath'] ?? 'default_image.png',
          name: expert['name'] ?? 'Expert Name',
          role: expert['role'] ?? 'Specialty',
          bio: expert['bio'] ?? 'bio',
          subscriptionPrice: expert['subscriptionPrice'] ?? 0,
          loves: expert['loves'] ?? 0,
        );
      },
    );
  }
}
