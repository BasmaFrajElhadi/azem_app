import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';

class AnalysisTabBar extends StatefulWidget {
  const AnalysisTabBar({super.key});

  @override
  _AnalysisTabBarState createState() => _AnalysisTabBarState();
}

class _AnalysisTabBarState extends State<AnalysisTabBar> {
  DateTime _selectedDay = DateTime.now(); // Default to today's date
  List<DateTime> weekDates = []; // Store the week dates

  // Arabic weekday labels for display
  final List<String> daysOfWeekArabic = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة"
  ];

  // Function to calculate the week dates based on a given date
  List<DateTime> getWeekDates(DateTime date) {
    int currentWeekday = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentWeekday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // Function to open the date picker
  void _openDatePicker(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDay = selectedDate; // Update the selected day
        weekDates = getWeekDates(selectedDate); // Update week dates based on selected date
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'أيام الإسبوع',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: () => _openDatePicker(context), // Open date picker on tap
              child: Image.asset(IconsPath.calendarIcon),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBetweenItemsMd),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Row(
            children: List.generate(7, (index) {
              DateTime day = weekDates[index];
              String dayLabel = daysOfWeekArabic[index];

              return FilterChip(
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
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${day.day}', // Day of the month
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedDay.day == day.day &&
                            _selectedDay.month == day.month &&
                            _selectedDay.year == day.year
                            ? Colors.white
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
                    _selectedDay = day; // Update selected day when chip is tapped
                  });
                },
                selectedColor: AppColors.primaryColor,
                backgroundColor: AppColors.white,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFFEEDDEE),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              );
            }),
          ),
        ),
      ],
    );
  }
}
