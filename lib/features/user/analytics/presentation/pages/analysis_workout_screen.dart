import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';


class AnalysisWorkoutScreen extends StatelessWidget {
  AnalysisWorkoutScreen({super.key});
  final List<String> titles = [
    'عنوان الوجبة 1',
    'عنوان الوجبة 2',
    'عنوان الوجبة 3',
    'عنوان الوجبة 4',
  ];

  final List<String> texts = [
    'هذه هي تفاصيل الوجبة رقم 1. هنا يمكنك إضافة المزيد من المعلومات حول الوجبة.',
    'هذه هي تفاصيل الوجبة رقم 2. هنا يمكنك إضافة المزيد من المعلومات حول الوجبة.',
    'هذه هي تفاصيل الوجبة رقم 3. هنا يمكنك إضافة المزيد من المعلومات حول الوجبة.',
    'هذه هي تفاصيل الوجبة رقم 4. هنا يمكنك إضافة المزيد من المعلومات حول الوجبة.',
  ];
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
              children: [
                const TextAppBar(title: 'التمارين'),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                // Insert TimelineCards here
                ...List.generate(titles.length, (i) {
                  return workoutCard(
                    title: titles[i],
                    text: texts[i],
                    imagePath: 'assets/images/Squats.jpg',
                    id: i,
                  );
                }),

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
class workoutCard extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;
  final int id;

  const workoutCard({
    super.key,
    required this.title,
    required this.text,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row to align the image and text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded widget to allow text to take available space
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppSizes.fontSizeMd,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: AppSizes.fontSizeSm,
                          color: AppColors.textSecondary
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}










