import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../pages/newChat.dart';

class NewProgramAppBar extends StatelessWidget {
  final String title;

  const NewProgramAppBar({
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
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewChatScreen()),
                );
              },
              child:Image.asset(
                'assets/icons/mainIcon/chat.png',
                height: AppSizes.iconXxl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
