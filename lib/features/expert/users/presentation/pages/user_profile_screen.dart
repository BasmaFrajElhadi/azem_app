import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../../../../user/analytics/presentation/pages/analysis_meals_screen.dart';
import '../../../../user/analytics/presentation/pages/analysis_workout_screen.dart';
import '../../../../user/analytics/presentation/widgets/analysis_tabs.dart';
import '../../../../user/analytics/presentation/widgets/calories_burned.dart';
import '../../../../user/analytics/presentation/widgets/calories_grid.dart';
import '../../../../user/analytics/presentation/widgets/total_calories.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
              children: [
                const TextAppBar(title: 'اداء المشترك'),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'محمد علي',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Height Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'الطول',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: AppSizes.sm),
                            Text(
                              '170 سم', // Replace with dynamic data
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBetweenItemsMd),

                    // Weight Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'الوزن',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: AppSizes.sm),
                            Text(
                              '70 كغ', // Replace with dynamic data
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBetweenItemsMd),

                    // Age Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'العمر',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: AppSizes.sm),
                            Text(
                              '25 سنة', // Replace with dynamic data
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'مشاكل صحية',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: AppSizes.sm),
                        Text(
                          ' الم بالظهر',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const AnalysisTabBar(),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const CaloriesBurned(),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const TotalCalories(),
                const SizedBox(height: AppSizes.spaceBetweenItemsSm),
                const SizedBox(
                  height: 170,
                  child: CaloriesGrid(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AnalysisWorkoutScreen()),
                          );
                        },
                        child:  Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column( // Changed to Column to stack content vertically
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                            children: [
                              // Image at the top
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ImagesPath.analysisImageTwo,
                                  fit: BoxFit.cover,
                                  height: 150, // Adjust image height
                                ),
                              ),
                              // Title in the middle
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "التمارين التي قام بها",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center, // Center the text
                                ),
                              ),
                              // Button at the bottom
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnalysisWorkoutScreen(),
                                      ),
                                    );

                                  },
                                  child: const Text(
                                    'عرض التفاصيل',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: AppSizes.spaceBetweenItemsSm), // Add some space between the two cards
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AnalysisMealsScreen()),
                          );
                        },
                        child:Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                            children: [
                              // Image at the top
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ImagesPath.analysisImageOne,
                                  fit: BoxFit.cover,
                                  height: 150, // Adjust image height
                                ),
                              ),
                              // Title in the middle
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "الوجبات التي تناولها",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center, // Center the text
                                ),
                              ),
                              // Button at the bottom
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AnalysisMealsScreen(),
                                      ),
                                    );

                                  },
                                  child: const Text(
                                    'عرض التفاصيل',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}










