import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';

class ExpertHomeCard extends StatefulWidget {
  final String image;
  final String name;
  final String role;
  final int initialLikes;

  const ExpertHomeCard({
    super.key,
    required this.image,
    required this.name,
    required this.role,
    required this.initialLikes,
  });

  @override
  _ExpertHomeCardState createState() => _ExpertHomeCardState();
}

class _ExpertHomeCardState extends State<ExpertHomeCard> {
  bool isLiked = false;
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likes++;
      } else {
        likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Row(
            children: [
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.image,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Name and Role in the center
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.role,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Likes and Heart on the right
              Column(
                children: [
                  // Clickable Heart Image
                  GestureDetector(
                    onTap: _toggleLike, // Toggle like on tap
                    child: Image.asset(
                      isLiked ? IconsPath.filledFavoriteIcon : IconsPath.favoriteIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('$likes',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
