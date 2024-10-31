
import 'dart:ui';

import 'package:azem/features/user/programs/presentation/widgets/programs_app_bar.dart';
import 'package:flutter/material.dart';


import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../widgets/program_tab_bar.dart';

class MealProgramScreen extends StatelessWidget {
  const MealProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lists of titles and texts for the timeline cards
    final List<String> titles = [
      ' وجبة الفطور',
      'وجبة الغذاء',
      'وجبة العشاء',
      ' وجبة خفيفة',
    ];

    final List<String> texts = [
      ' شوفان مع فواكه طازجة مثل التوت والموز، مع القليل من العسل وحفنة من المكسرات الصحية.',
      ' صدر دجاج مشوي مع خضروات مشوية مثل الكوسا والفلفل الأحمر، يقدم مع الأرز البني وسلطة جانبية.',
      'زبادي يوناني مع ملعقة صغيرة من بذور الشيا والفواكه المفضلة لديك مثل الكيوي أو الفراولة.',
      '  سمك السلمون المشوي مع البروكلي والبطاطا الحلوة المهروسة، وتوابل خفيفة لإضافة النكهة.',
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
                const ProgramAppBar(title: "برنامجك الغذائي"),
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
                // Timeline Cards with Indicators
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                  ),
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
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                    ],
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
            height: widget.index == 3 ? 0 : 120, // Height of the line
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

  const TimelineCard({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
