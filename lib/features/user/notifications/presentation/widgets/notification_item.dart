import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';

class NotificationItem extends StatelessWidget {
  final String text;

  const NotificationItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentLightBlue,
                border: Border.all(color: AppColors.primaryColor,width: 2)
              ),
              child: Image.asset(
                IconsPath.notificationIcon,
                height: AppSizes.iconMd,
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: AppSizes.fontSizeSm,
                  color: AppColors.textSecondary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        const Divider(
          color: AppColors.mediumLightGray,
          thickness: 1,
        ),
      ],
    );
  }
}
