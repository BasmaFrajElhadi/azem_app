import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../../../userManagement/presentation/provider/current_user_provider.dart';
import '../../domain/entities/daily_food_ration_entity.dart';
import '../provider/daily_food_ration_provider.dart';
import '../provider/get_current_slider_food.dart';
import '../widgets/calories_card.dart';
import '../widgets/meal_search_bar.dart';
import '../widgets/meal_slider.dart';

class CaloriesCalculatorScreen extends StatefulWidget {
  final int mealId;

  const CaloriesCalculatorScreen({
    super.key,
    required this.mealId,
  });

  @override
  _CaloriesCalculatorScreenState createState() => _CaloriesCalculatorScreenState();
}

class _CaloriesCalculatorScreenState extends State<CaloriesCalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late Future<dartz.Either<Failure, List<DailyFoodRationEntity>>> dailyMealsData;
  List<List<Map<String, dynamic>>> mealData = List.generate(5, (_) => []);


  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    final todayDate = DateTime.now();
    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    String email = Provider.of<CurrentUserProvider>(context,listen: false).email;
    Provider.of<DailyFoodRationProvider>(context, listen: false).updateDailyMealsData(widget.mealId,today,email);
    _fetchMealData();

  }
  Future<void> _fetchMealData() async {
    for (int i = 0; i < 5; i++) {
      final categoryMeals = await FirebaseFirestore.instance.collection('foods')
          .where('foodType', isEqualTo: _getTabTitle(i))
          .get();

      mealData[i] = categoryMeals.docs.map((doc) {
        return {
          'imagePath': doc.data()['imagePath'] ?? 'assets/images/fallback.png',
          'foodName': doc.data()['foodName'] ?? 'عنصر غير معروف',
          'caloriesPerUnit': doc.data()['caloriesPerUnit']?.toString() ?? '0',
          'carbs': doc.data()['carbs']?.toString() ?? '0',
          'fat': doc.data()['fat']?.toString() ?? '0',
          'fiber': doc.data()['fiber']?.toString() ?? '0',
          'protein': doc.data()['protein']?.toString() ?? '0',
          'sodium': doc.data()['sodium']?.toString() ?? '0',
          'defaultUnit': doc.data()['defaultUnit'] ?? '',
        };
      }).toList();
    }
    Provider.of<GetCurrentSliderFoodProvider>(context, listen: false)
        .setCurrentMeal(mealData[0][0]);
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMealSizeDialog() {
    int serviceAmount = 1;
    String? selectedMealSize;
    TextEditingController amountController = TextEditingController(text: serviceAmount.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'اختار حجم الحصة',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedMealSize, // Default value if null
                        isExpanded: true,
                        dropdownColor: AppColors.primaryColor,
                        underline: const SizedBox(),
                        hint: const Text(
                          'اختار حجم الحصة',
                          style: TextStyle(color: Colors.white),
                        ),
                        items: [
                          "جرام",
                          "ملعقة صغيرة",
                          "ملعقة كبيرة",
                          "كوب",
                          "1/2 كوب",
                          "1/4 كوب"
                        ].map((String size) {
                          return DropdownMenuItem<String>(
                            value: size,
                            child: Text(
                              size,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMealSize = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'كمية الحصة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {
                          serviceAmount = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedMealSize != null ? () async {
                        // Save meal to Firestore
                        final todayDate = DateTime.now();
                        final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
                        DailyFoodRationEntity dailyFoodRationEntity = DailyFoodRationEntity(
                          userEmail: Provider.of<CurrentUserProvider>(context, listen: false).email,
                          foodName: Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['foodName'],
                          imagePath: Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['imagePath'],
                          calories: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['caloriesPerUnit']),
                          carbs: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['carbs']),
                          fat: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['fat']),
                          fiber: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['fiber']),
                          protein: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['protein']),
                          sodium: double.parse(Provider.of<GetCurrentSliderFoodProvider>(context, listen: false).currentMeal?['sodium']),
                          date: today,
                          mealTimes: widget.mealId,
                          amount: serviceAmount,
                          size: selectedMealSize!, // Use the selected size here
                        );
                        Provider.of<DailyFoodRationProvider>(context, listen: false).setTodayFoodRation(dailyFoodRationEntity);

                        Navigator.pop(context); // Close the dialog
                      } : null, // Disable button if no meal size is selected
                      child: const Text('اضافة'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
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
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextAppBar(title: Provider.of<DailyFoodRationProvider>(context, listen: false).getMealNameById(widget.mealId)),
                        const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                        const MealSearchBar(),
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
                            children: List.generate(5, (index) {
                              return MealsSlider(meals: mealData[index]);
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.xl, right: AppSizes.md,left: AppSizes.md),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  _showMealSizeDialog();},
                                child: Image.asset(IconsPath.addIcon, height: AppSizes.iconXl),
                              ),
                              const SizedBox(width: AppSizes.spaceBetweenItemsXl),
                              Consumer<DailyFoodRationProvider>(
                                builder: (context, provider, child) {
                                  return Text(
                                      "${provider.totalCalories}",
                                      style: const TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                      ));
                                },
                              ),
                              const Text(
                                'سعرة حرارية',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceBetweenItemsXl),
                              const SizedBox(height: AppSizes.spaceBetweenItemsLg),
                              Consumer<DailyFoodRationProvider>(
                                builder: (context, provider, child) {
                                  if (provider.isLoading) {
                                    return const CircularProgressIndicator(); // Loading state
                                  } else if (provider.errorMessage != null) {
                                    return const Text('لم تقم باضافة الوجبات بعد...'); // Error state
                                  } else if (provider.todayFoodRation.isEmpty) {
                                    return const Text('لم تقم باضافة الوجبات بعد...'); // Empty state
                                  } else {
                                    return Column(
                                      children: provider.todayFoodRation.map((meal) {
                                        return Column(
                                          children: [
                                            CaloriesCard(mealData: meal), // Display each meal
                                            const SizedBox(height: 10), // Space between cards
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'لحوم';
      case 1:
        return 'فواكه';
      case 2:
        return 'خضروات';
      case 3:
        return 'منتجات ألبان';
      case 4:
        return 'حبوب';
      default:
        return '';
    }
  }
}


