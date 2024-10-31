import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import 'analysis_meals_screen.dart';
import 'analysis_workout_screen.dart';
import '../widgets/calories_burned.dart';
import '../widgets/calories_grid.dart';
import '../widgets/total_calories.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  DateTime _selectedDay = DateTime.now(); // Default to today's date
  List<DateTime> weekDates = []; // Store the week dates

  final List<String> daysOfWeekArabic = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة"
  ];

  List<DateTime> getWeekDates(DateTime date) {
    int currentWeekday = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentWeekday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void _openDatePicker(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDay = selectedDate;
        weekDates = getWeekDates(selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    weekDates = getWeekDates(_selectedDay); // Initialize week dates
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
        child: ListView(
              children: [
                const TextAppBar(title: 'أداءك'),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'أيام الإسبوع',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _openDatePicker(context),
                          child: Image.asset(IconsPath.calendarIcon),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(7, (index) {
                          DateTime day = weekDates[index];
                          String dayLabel = daysOfWeekArabic[index];
                          return Row(
                            children: [
                              FilterChip(
                                label: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dayLabel,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _selectedDay.day == day.day &&
                                            _selectedDay.month == day.month &&
                                            _selectedDay.year == day.year
                                            ? AppColors.white
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _selectedDay.day == day.day &&
                                            _selectedDay.month == day.month &&
                                            _selectedDay.year == day.year
                                            ? AppColors.white
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                selected: _selectedDay.day == day.day &&
                                    _selectedDay.month == day.month &&
                                    _selectedDay.year == day.year,
                                onSelected: (isSelected) {
                                  setState(() {
                                    _selectedDay = day;
                                  });
                                },
                                selectedColor: AppColors.primaryColor,
                                backgroundColor: AppColors.white,
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              const SizedBox(width: 5),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اليوم",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppSizes.fontSizeMd,
                      ),
                    ),
                    SizedBox(height: AppSizes.sm,),
                    Text(
                      "22,10,2024",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsSm),
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
                        child: Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ImagesPath.analysisImageTwo,
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "التمارين التي قمت بها",
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSizeSm,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
                                      fontSize: AppSizes.fontSizeXs,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBetweenItemsSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AnalysisMealsScreen()),
                          );
                        },
                        child: Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  ImagesPath.analysisImageOne,
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "الوجبات التي تناولتها",
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSizeSm,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
                                      fontSize: AppSizes.fontSizeXs,
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


