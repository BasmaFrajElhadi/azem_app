import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';

class ExpertAppBar extends StatelessWidget {
  const ExpertAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.appBarHeightSm,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            IconsPath.backArrowIcon,
            height: AppSizes.iconMd,
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
