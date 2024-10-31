import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../pages/calories_calculator.dart';

class MealsCardRightSide extends StatelessWidget {
  final int mealId;
  final String title;
  final String subtitle;
  final String imagePath;

  const MealsCardRightSide({
    super.key,
    required this.mealId,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: const Color(0xFFEDEDED)),
          ),
          child: Row(
            children: [
              const Expanded(child: Column()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppSizes.fontSizeMd,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaloriesCalculatorScreen(mealId: mealId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'إضافة',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.fontSizeSm,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
        Positioned(
          right: -20,
          top: 0,
          child: Image.asset(
            imagePath,
            height: 150,
            width: 150,
          ),
        ),
      ],
    );
  }
}
