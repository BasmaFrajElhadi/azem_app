import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../widgets/analysis_meals_card.dart';


class AnalysisMealsScreen extends StatelessWidget {
  const AnalysisMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
                children: [
            Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [
            AppColors.primaryColor.withOpacity(0.8),
            Colors.white
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

        ),
      ),
      // Glassmorphism effect
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      // Content of the screen
      Padding(
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
                 )
             ),],
            ),
          ),
        ),
      )
    );
  }
}










