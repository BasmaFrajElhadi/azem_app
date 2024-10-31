import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/icons_path.dart';
import '../constants/sizes.dart';


class TextAppBar extends StatelessWidget {
  final String title;

  const TextAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.appBarHeightSm,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Back button
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:Image.asset(
                IconsPath.backArrowIcon,
                height: AppSizes.iconXxl,
              ),
            ),
          ),
          // Centered title
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.fontSizeLg,
                color: AppColors.textPrimary
              ),
            ),
          ),
        ],
      ),
    );
  }
}
