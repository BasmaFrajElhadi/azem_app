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
      backgroundColor: AppColors.backgroundLight,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
            child: ListView(
              children: [
                const TextAppBar(title: 'التمارين'),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                // Insert TimelineCards here
                ...List.generate(titles.length, (i) {
                  return TimelineCard(
                    title: titles[i],
                    text: texts[i],
                    imagePath: 'assets/images/Squats.jpg',
                    id: i,
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TimelineCard extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;
  final int id;

  const TimelineCard({
    super.key,
    required this.title,
    required this.text,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white, // Set card color to white
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
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2, // Limit the number of lines for the text to prevent overflow
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflowed text
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Image on the right side, wrapped in Flexible to handle overflow
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










