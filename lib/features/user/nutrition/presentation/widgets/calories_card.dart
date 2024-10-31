import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../domain/entities/daily_food_ration_entity.dart';
import '../provider/daily_food_ration_provider.dart';


class CaloriesCard extends StatelessWidget {
  final DailyFoodRationEntity mealData;

  const CaloriesCard({
    super.key,
    required this.mealData,
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
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: const Color(0xFFEDEDED)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<DailyFoodRationProvider>(context, listen: false)
                      .deleteTodayFoodRation(mealData.id??'');

                },
                child: Image.asset(
                  IconsPath.minusIcon,
                  height: AppSizes.iconMd,
                ),
              ),
              const SizedBox(width: AppSizes.spaceBetweenItemsMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${mealData.amount} ${mealData.size}  ${mealData.foodName} ",
                    style: const TextStyle(
                      fontSize: AppSizes.fontSizeMd,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.calories} سعرة حرارية ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.carbs} كربوهيدرات ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.fat} دهون ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.fiber}  ألياف ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.protein}  بروتين ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${mealData.sodium} صوديوم ",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontSizeXs,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Image
        Positioned(
          left: -10,
          top: 0,
          child: Image.network(
            mealData.imagePath,
            height: 80,
            width: 80,
          ),
        ),
      ],
    );
  }
}
