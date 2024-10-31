import 'dart:ui';
import 'package:azem/features/expert/core/widget/expert_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/plans_carousel.dart';


class ExpertHomeScreen extends StatelessWidget {
  const ExpertHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: ExpertBottomBar(
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
                    children: const [
                      SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      HomeSearchBar(),
                      SizedBox(height: AppSizes.spaceBetweenItemsLg),
                      Text(
                        "برامجك الحالية",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      SizedBox(height: AppSizes.spaceBetweenItemsSm),
                      PlansCarousel(),
                      SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      Text(
                        "أشهر الخبراء",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      SizedBox(height: AppSizes.spaceBetweenItemsSm),
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

