import 'dart:ui';

import 'package:azem/features/user/programs/presentation/pages/workout.dart';
import 'package:flutter/material.dart';


import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../widgets/program_tab_bar.dart';
import '../widgets/programs_app_bar.dart';


class WorkoutsProgramScreen extends StatelessWidget {
  const WorkoutsProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lists of titles and texts for the timeline cards
    final List<String> titles = [
      'تمرين الضغط',
      'تمرين السكوات',
      'تمرين البلانك',
      'تمرين الاندفاع',
    ];

    final List<String> texts = [
      'تمرين الضغط: يساعد على تقوية عضلات الصدر، الأكتاف، والذراعين. يُنفذ عن طريق رفع الجسم بواسطة اليدين، مع الحفاظ على استقامة الظهر.',
      'تمرين السكوات: يعمل على تقوية عضلات الأرجل والأرداف، ويعزز التوازن والاستقرار. يُنفذ عبر الجلوس بشكل جزئي وكأنك تجلس على كرسي.',
      'تمرين البلانك: تمرين أساسي لتقوية عضلات البطن والظهر. يُنفذ بالاستلقاء على البطن، ثم رفع الجسم مستنداً على الساعدين وأصابع القدمين مع الحفاظ على استقامة الجسم.',
      'تمرين الاندفاع: يركز على عضلات الأرجل والأرداف ويعزز التوازن. يُنفذ بخطوة للأمام مع ثني الركبة والعودة للوضع الأولي بالتناوب بين الساقين.',
    ];


    final List<String> imagePath = [
      'assets/images/Squats.jpg',
      'assets/images/Squats.jpg',
      'assets/images/Squats.jpg',
      'assets/images/Squats.jpg',
    ];


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
        // Glassmorphism effect across the screen
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
              const ProgramAppBar(title: 'برنامجك الرياضي'),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              const ProgramTabBar(),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "31 اكتوبر 2024",
                    style: TextStyle(fontSize: 14, color: AppColors.gray),
                  ),
                  SizedBox(height: AppSizes.spaceBetweenItemsSm),
                  Text(
                    "اليوم الأول",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBetweenItemsSm),
                Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),)),
                  child: Column(
                    children: List.generate(titles.length, (i) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline Column
                          Expanded(
                            child: TimelineIndicator(
                              index: i,
                            ),
                          ),
                          // Card Column
                          Expanded(
                            flex: 5,
                            child: TimelineCard(
                              title: titles[i],
                              text: texts[i],
                              imagePath: imagePath[i],
                              id: i,
                            ),

                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ]
          ),
        ),
                  ],
              ),
            ),
          ),
        ),
    );
  }
}

class TimelineIndicator extends StatefulWidget {
  final int index;

  const TimelineIndicator({super.key, required this.index});

  @override
  _TimelineIndicatorState createState() => _TimelineIndicatorState();
}

class _TimelineIndicatorState extends State<TimelineIndicator> {
  Color indicatorColor = AppColors.mediumGray;
  Color lineColor = AppColors.mediumGray;
  bool isChecked = false;

  void _onIndicatorTap() {
    setState(() {
      if (indicatorColor == AppColors.primaryColor) {
        indicatorColor = AppColors.mediumGray;
        lineColor = AppColors.mediumGray;
        isChecked = false;
      } else {
        indicatorColor = AppColors.primaryColor;
        lineColor = AppColors.primaryColor;
        isChecked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onIndicatorTap,
      child: Column(
        children: [
          // Circle Indicator
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: indicatorColor,
            ),
            child: Center(
              child: isChecked
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          ),
          // Line
          Container(
            width: 4, // Width of the line
            height: widget.index == 3 ? 0 : 170, // Height of the line
            color: lineColor,
          ),
        ],
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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary
                        ),
                        maxLines: 2, // Limit the number of lines for the text to prevent overflow
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflowed text
                      ),
                      const SizedBox(height: 8),
                      // Button below the text
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the WorkoutsScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WorkoutsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor, // Adjust button color
                        ),
                        child: const Text("ابدأ التمرين",style: TextStyle(color:Colors.white,fontSize: 14),),
                      ),
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
