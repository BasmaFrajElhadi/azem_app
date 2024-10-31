import 'package:flutter/material.dart';
import '../../../../core/constants/icons_path.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.appBarHeightSm,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Navigate back when tapped
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              IconsPath.backArrowIcon,
              height: AppSizes.iconXxl,
            ),
          ),
          ClipOval(
            child: Container(
              padding: const EdgeInsets.all(AppSizes.md),
              color: AppColors.mediumLightGray,
              child: Image.asset(
                IconsPath.userIcon,
                height: AppSizes.iconMd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
