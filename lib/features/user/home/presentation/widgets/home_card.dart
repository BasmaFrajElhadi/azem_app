import 'package:flutter/material.dart';

import '../../../../../core/constants/sizes.dart';

class IconCard extends StatelessWidget {
  final String icon; // The icon for the widget
  final Color cardColor; // The color of the card background
  final Color circleColor; // The color of the circle around the icon
  final String text; // The text below the icon

  const IconCard({
    super.key,
    required this.icon,
    required this.cardColor,
    required this.circleColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.iconSm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBetweenItemsMd),
            // Text under the icon
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppSizes.fontSizeLg,
                fontWeight: FontWeight.w600,
                color: Colors.black,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
