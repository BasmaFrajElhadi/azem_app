import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';

class ChatAppBar extends StatelessWidget {
  final String title;
  final String userName; // Parameter for the user's name
  final String userImage; // Parameter for the user's image URL or asset path

  const ChatAppBar({
    super.key,
    required this.title,
    required this.userName, // Initialize the new parameter
    required this.userImage, // Initialize the new parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.appBarHeightSm,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              IconsPath.backArrowIcon,
              height: AppSizes.iconXxl,
            ),
          ),
          // User image and name on the left
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.lg),
            child: Row(
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeMd,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSizes.sm), // Space between image and text
                CircleAvatar(
                  backgroundImage: AssetImage(userImage), // Use AssetImage for local assets
                  radius: 20, // Adjust the radius as needed
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
