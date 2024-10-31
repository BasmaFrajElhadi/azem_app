import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../widgets/meals_left_card.dart';
import '../widgets/meals_right_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
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
            children: const [
              TextAppBar(title: 'اضافة الوجبات'),
              SizedBox(height: AppSizes.spaceBetweenItemsMd),
              MealsCardLeftSide(
                mealId:1,
                title: 'وجبة الإفطار',
                subtitle: 'نوصي بحوالي 20-25% \nمن الاحتياج اليومي',
                imagePath: ImagesPath.breakfastImage,
              ),
              SizedBox(height: AppSizes.spaceBetweenItemsMd),
              MealsCardRightSide(
                mealId:2,
                title: 'وجبة الغذاء',
                subtitle: 'نوصي بحوالي 30-35% \nمن الاحتياج اليومي',
                imagePath: ImagesPath.lunchImage,
              ),
              SizedBox(height: AppSizes.spaceBetweenItemsMd),
              MealsCardLeftSide(
                mealId:4,
                title: 'وجبة خفيفة',
                subtitle: 'نوصي بحوالي 25-30% \nمن الاحتياج اليومي',
                imagePath: ImagesPath.snakeImage,
              ),
              SizedBox(height: AppSizes.spaceBetweenItemsMd),
              MealsCardRightSide(
                mealId:3,
                title: 'وجبة العشاء',
                subtitle: 'نوصي بحوالي 10-15%\n  من الاحتياج اليومي',
                imagePath: ImagesPath.dinnerImage,
              ),
              SizedBox(height: AppSizes.spaceBetweenItemsMd),
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
