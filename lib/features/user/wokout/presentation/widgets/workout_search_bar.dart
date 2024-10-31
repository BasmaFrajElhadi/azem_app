import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';

class WorkoutSearchBar extends StatelessWidget {
  const WorkoutSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadiusLg),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Row(
        children: [
          // Search icon
          Image.asset(
            IconsPath.searchIcon,
            height: AppSizes.iconMd,
          ),
          const SizedBox(width: AppSizes.md),
          // TextField for search input
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن التمارين...',
                hintStyle: TextStyle(color: AppColors.textHint),
                border: InputBorder.none,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
