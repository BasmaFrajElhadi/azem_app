import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../widgets/expert_home_card.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/plans_carousel.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardData = [
      {
        'image': 'assets/images/expert/trainers/tranier4.jpg',
        'name': 'محمد علي',
        'role': 'مدرب رياضي',
        'likes': 150
      },
      {
        'image': 'assets/images/expert/trainers/tranier4.jpg',
        'name': 'محمد علي',
        'role': 'مدرب رياضي',
        'likes': 230
      },
      {
        'image': 'assets/images/expert/nutritionist/nutritionist1.jpg',
        'name': 'علي مراد',
        'role': 'اخصائي تغذية',
        'likes': 230
      },
      {
        'image': 'assets/images/expert/trainers/tranier5.jpg',
        'name': 'علي مراد',
        'role': 'اخصائي تغذية',
        'likes': 230
      },
      {
        'image': 'assets/images/expert/trainers/tranier8.jpg',
        'name': 'محمد علي',
        'role': 'مدرب رياضي',
        'likes': 100
      },
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
                      const MainAppBar(),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const HomeSearchBar(),
                      const SizedBox(height: AppSizes.spaceBetweenItemsLg),
                      const Text(
                        "برامجك الحالية",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsSm),
                      const PlansCarousel(),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const Text(
                        "أشهر الخبراء",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsSm),
                      //list of popular experts
                      Column(
                        children: cardData.map((data) {
                          return ExpertHomeCard(
                            image: data['image'],
                            name: data['name'],
                            role: data['role'],
                            initialLikes: data['likes'],
                          );
                        }).toList(),
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

