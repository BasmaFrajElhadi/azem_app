import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';

class SetPlanNutraionScreen extends StatefulWidget {
  const SetPlanNutraionScreen({super.key});

  @override
  _SetPlanNutraionScreenState createState() => _SetPlanNutraionScreenState();
}

class _SetPlanNutraionScreenState extends State<SetPlanNutraionScreen> {
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 6)),
    end: DateTime.now(),
  );

  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  final List<String> titles = ['وجبة الفطور', 'وجبة الغداء', 'وجبة العشاء', 'وجبة خفيفة'];
  List<String> savedTexts = List.generate(4, (index) => '');
  List<bool> isEditMode = List.generate(4, (index) => true);
  List<bool> isIndicatorChecked = List.generate(4, (index) => false);

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
                const TextAppBar(title: 'تصميم جدول الوجبات'),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: selectedDate,
                    selectedDayPredicate: (day) {
                      return isSameDay(day, selectedDate) ||
                          (day.isAfter(selectedRange.start.subtract(const Duration(days: 1))) &&
                              day.isBefore(selectedRange.end.add(const Duration(days: 1))));
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      rangeHighlightColor: AppColors.primaryColor.withOpacity(0.3),
                      withinRangeDecoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      outsideDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
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
                              isChecked: isIndicatorChecked[i], // Check the current indicator
                            ),
                          ),
                          // Card Column with Text Field and Save Button
                          Expanded(
                            flex: 5,
                            child: TimelineCardWithTextField(
                              title: titles[i],
                              controller: controllers[i],
                              savedText: savedTexts[i],
                              isEditMode: isEditMode[i],
                              onSave: () {
                                setState(() {
                                  if (isEditMode[i]) {
                                    // Save the text and switch to view mode
                                    savedTexts[i] = controllers[i].text;
                                    isEditMode[i] = false;
                                    // Mark the current circle as checked when saving the card
                                    isIndicatorChecked[i] = true;
                                  } else {
                                    // Switch back to edit mode
                                    isEditMode[i] = true;
                                  }
                                });
                              },
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
        ),
      ),
    );
  }
}

class TimelineIndicator extends StatelessWidget {
  final int index;
  final bool isChecked;

  const TimelineIndicator({super.key, required this.index, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    Color indicatorColor = isChecked ? AppColors.primaryColor : AppColors.mediumGray;
    Color lineColor = isChecked ? AppColors.primaryColor : AppColors.mediumGray;

    return Column(
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
          width: 4,
          height: index == 3 ? 0 : 170,
          color: lineColor,
        ),
      ],
    );
  }
}

class TimelineCardWithTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String savedText;
  final bool isEditMode;
  final VoidCallback onSave;

  const TimelineCardWithTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.savedText,
    required this.isEditMode,
    required this.onSave,
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
            // Card Title
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Display TextField or Text based on edit mode
            isEditMode
                ? TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: savedText.isEmpty ? 'أدخل تفاصيل الوجبة هنا' : savedText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            )
                : Text(
              savedText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Save/Edit Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: Text(isEditMode ? 'حفظ' : 'تعديل', style: const TextStyle(color: AppColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
