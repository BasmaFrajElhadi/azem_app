import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../../../../user/wokout/presentation/widgets/workout_card.dart';
import '../../../../user/wokout/presentation/widgets/workout_slider.dart';

class SetPlanWorkoutScreen extends StatefulWidget {
  const SetPlanWorkoutScreen({super.key});

  @override
  _SetPlanWorkoutScreenState createState() => _SetPlanWorkoutScreenState();
}

class _SetPlanWorkoutScreenState extends State<SetPlanWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedRange = DateTimeRange(
    start: DateTime(2024, 10, 1),
    end: DateTime(2024, 10, 7),
  );


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: workoutData.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

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
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundLight,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.md),
                  child: Column(
                    children: [
                      TextAppBar(title: 'تصميم جدول التمارين'),
                      SizedBox(height: AppSizes.spaceBetweenItemsMd),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // TableCalendar added here
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: selectedDate,
                  selectedDayPredicate: (day) {
                    // Highlight the selected date or dates within the default range
                    return isSameDay(day, selectedDate) ||
                        (day.isAfter(selectedRange.start.subtract(const Duration(days: 1))) &&
                            day.isBefore(selectedRange.end.add(const Duration(days: 1))));
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay; // Update the selected date
                      // Print the selected date
                      print('Selected date: ${selectedDate.toLocal()}'); // Print the date in local format
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primaryColor, // Color for selected date
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: AppColors.secondaryColor, // Color for today's date
                      shape: BoxShape.circle,
                    ),
                    rangeHighlightColor: AppColors.primaryColor.withOpacity(0.3), // Highlight the range
                    withinRangeDecoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.2), // Color for the dates within the range
                      shape: BoxShape.circle,
                    ),
                    outsideDecoration: const BoxDecoration( // Use 'outsideDecoration' instead
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: AppColors.backgroundLight,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: AppColors.textPrimary,
                  labelColor: AppColors.white,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  indicator: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  tabs: List.generate(workoutData.length, (index) {
                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.sm, horizontal: AppSizes.lg),
                        decoration: BoxDecoration(
                          color: _tabController.index == index
                              ? AppColors.primaryColor
                              : AppColors.mediumLightGray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(_getTabTitle(index)),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: TabBarView(
                  controller: _tabController,
                  children: workoutData.map((workouts) {
                    return WorkoutSlider(workouts: workouts);
                  }).toList(),
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
        ),
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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
