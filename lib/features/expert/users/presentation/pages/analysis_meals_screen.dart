
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../../../../user/analytics/presentation/widgets/analysis_meals_card.dart';


class AnalysisMealsScreen extends StatelessWidget {
  const AnalysisMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
            child: ListView(
              children: const [
                TextAppBar(title: 'الوجبات'),
                SizedBox(height: AppSizes.spaceBetweenItemsMd),
                AnalysisMealsCard(
                  title: 'بيض',
                  subtitle: '200 سعرة حرارية\n 20 دهون \n 3 صوديوم',
                  imagePath: ImagesPath.snakeImage,
                ),
                SizedBox(height: AppSizes.spaceBetweenItemsMd),
                AnalysisMealsCard(
                  title: 'بيض',
                  subtitle: '200 سعرة حرارية\n 20 دهون \n 3 صوديوم',
                  imagePath: ImagesPath.snakeImage,
                ),
                SizedBox(height: AppSizes.spaceBetweenItemsMd),
                AnalysisMealsCard(
                  title: 'بيض',
                  subtitle: '200 سعرة حرارية\n 20 دهون \n 3 صوديوم',
                  imagePath: ImagesPath.snakeImage,
                ),
                SizedBox(height: AppSizes.spaceBetweenItemsMd),
                AnalysisMealsCard(
                  title: 'بيض',
                  subtitle: '200 سعرة حرارية\n 20 دهون \n 3 صوديوم',
                  imagePath: ImagesPath.snakeImage,
                ),
                SizedBox(height: AppSizes.spaceBetweenItemsMd),
                AnalysisMealsCard(
                  title: 'بيض',
                  subtitle: '200 سعرة حرارية\n 20 دهون \n 3 صوديوم',
                  imagePath: ImagesPath.snakeImage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}










