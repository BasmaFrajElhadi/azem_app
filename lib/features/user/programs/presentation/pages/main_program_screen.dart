import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';

import '../widgets/new_programs_app_bar.dart';

class MainProgramScreen extends StatelessWidget {
  final String expertEmail; // Email of the expert
  final String status; // Status (could be pending/active/finished)

  // Constructor to accept parameters
  const MainProgramScreen({
    super.key,
    required this.expertEmail,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
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
              // Glassmorphism effect
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              // Content of the screen
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
                child: Column(
                  children: [
                    const NewProgramAppBar(title: "برنامجك"),
                    const SizedBox(height: AppSizes.md),
                    const SizedBox(height: AppSizes.md),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (status == "pending")
                            const Text(
                              "انتظر ردا من الخبير في اقرب وقت",
                              style: TextStyle(
                                fontSize: AppSizes.fontSizeLg,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.md),
                            const Text(
                            "اذا كنت تواجه اي مشكلة يمكن ان تتواصل معنا",
                            style: TextStyle(
                              fontSize: AppSizes.fontSizeSm,
                              color: AppColors.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Add additional content for other statuses here if needed
                        ],
                      ),
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
}
