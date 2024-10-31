import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../widgets/workout_card.dart';
import '../widgets/workout_search_bar.dart';
import '../widgets/workout_slider.dart';

class WorkoutCalculatorScreen extends StatefulWidget {
  const WorkoutCalculatorScreen({
    super.key,
  });

  @override
  _WorkoutCalculatorScreenState createState() => _WorkoutCalculatorScreenState();
}

class _WorkoutCalculatorScreenState extends State<WorkoutCalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<List<Map<String, String>>> workoutData = [
    [
      {'image': 'assets/images/JumpRope.png', 'text': 'الجري'},
      {'image': 'assets/images/cycling.png', 'text': 'ركوب الدراجة'},
    ],
    [
      {'image': 'assets/images/JumpRope.png', 'text': 'رفع الأثقال'},
      {'image': 'assets/images/cycling.png', 'text': 'تمارين الضغط'},
    ],
    [
      {'image': 'assets/images/JumpRope.png', 'text': 'اليوغا'},
      {'image': 'assets/images/cycling.png', 'text': 'تمارين التمدد'},
    ],
    [
      {'image': 'assets/images/JumpRope.png', 'text': 'تمارين بيربي'},
      {'image': 'assets/images/cycling.png', 'text': 'القفز القرفصائي'},
    ],
    [
      {'image': 'assets/images/JumpRope.png', 'text': 'تحية الشمس'},
      {'image': 'assets/images/cycling.png', 'text': 'وضعية الشجرة'},
    ],
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Triggers rebuild when the tab is changed
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when the widget is destroyed
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TextAppBar(title: 'اضافة التمارين'),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              const WorkoutSearchBar(),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                unselectedLabelColor: AppColors.textPrimary,
                labelColor: AppColors.white,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicator: const BoxDecoration(
                  color: Colors.transparent,
                ),
                tabs: List.generate(5, (index) {
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.lg),
                      decoration: BoxDecoration(
                        color: _tabController.index == index
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Text(_getTabTitle(index)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    WorkoutSlider(workouts: workoutData[0]), // Tab 1
                    WorkoutSlider(workouts: workoutData[1]), // Tab 2
                    WorkoutSlider(workouts: workoutData[2]), // Tab 3
                    WorkoutSlider(workouts: workoutData[3]), // Tab 4
                    WorkoutSlider(workouts: workoutData[4]), // Tab 5
                  ],
                ),
              ),

              // Static content at the bottom
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
                child: Column(
                  children: [
                    // burned calories
                    const Text(
                      '500',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const Text(
                      'سعرة حرارية محروقة',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(IconsPath.addIcon, height: AppSizes.iconXl),
                        const SizedBox(width: AppSizes.spaceBetweenItemsXl),
                        const Text(
                          '5',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.xl,
                          ),
                        ),
                        const SizedBox(width: AppSizes.spaceBetweenItemsXl),
                        Image.asset(IconsPath.minusIcon, height: AppSizes.iconXl),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                    const WorkoutCard(
                      title: 'تمارين الضغط',
                      subtitle: '100 سعرة حرارية',
                      imagePath: 'assets/images/JumpRope.png',
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItemsLg),
                    const WorkoutCard(
                      title: 'تمارين القفز',
                      subtitle: '150 سعرة حرارية',
                      imagePath: 'assets/images/JumpRope.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),],
            ),
          ),
        ),
      )
    );
  }
  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'تمارين القلب';
      case 1:
        return 'القوة';
      case 2:
        return 'المرونة';
      case 3:
        return 'HIIT';
      case 4:
        return 'اليوغا';
      default:
        return '';
    }
  }
}
