import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../provider/current_user_provider.dart';
import 'edit_user_profile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isNotificationEnabled = false; //variable for the notification toggle

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    return   Scaffold(
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
                      const TextAppBar(title: "الملف الشخصي"),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      //User Image and Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  User Image and Name
                          Row(
                            children: [
                              // User Image
                              ClipOval(
                                child: Container(
                                  padding: const EdgeInsets.all(AppSizes.sm),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    IconsPath.userIcon,
                                    height: AppSizes.iconLg,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceBetweenItemsMd),
                              // User Name
                              Text(
                                "${currentUserProvider.firstName} ${currentUserProvider.lastName}",
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // modify button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditUserProfileScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'تعديل', // Button text
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // Row with three boxes for height, weight, and age
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Height Box
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(AppSizes.md),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'الطول',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.sm),
                                  Text(
                                    "${currentUserProvider.height} سم",
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.spaceBetweenItemsMd),
                          // Weight Box
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(AppSizes.md),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'الوزن',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.sm),
                                  Text(
                                    "${currentUserProvider.weight}كغ ",
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.spaceBetweenItemsMd),
                          // Age Box
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(AppSizes.md),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'العمر',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.sm),
                                  Text(
                                    "${currentUserProvider.age}  سنة ",
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // Account Box
                      Container(
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title of the Box
                            const Text(
                              'الحساب',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSizes.sm),
                            // List of items
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                // Likes Item
                                ListTile(
                                  leading: Image.asset(IconsPath.filledHearIcon),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'الاعجابات',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Image.asset(IconsPath.forwardArrowIcon,height: AppSizes.iconMd),
                                    ],
                                  ),
                                  onTap: () {

                                  },
                                ),
                                // Registered Programs Item
                                ListTile(
                                  leading: Image.asset(IconsPath.listIcon),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'البرامج المسجل فيها',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Image.asset(IconsPath.forwardArrowIcon,height: AppSizes.iconMd),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle tap
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),

                      // Notification Toggle
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSizes.md,horizontal: AppSizes.lg),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(IconsPath.bellIcon,height: AppSizes.iconSm,),
                                const SizedBox(width: AppSizes.sm),
                                const Text(
                                  'تفعيل الإشعارات',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isNotificationEnabled,
                              activeColor: AppColors.primaryColor,
                              inactiveTrackColor: AppColors.lightGray,
                              inactiveThumbColor: AppColors.mediumGray,
                              onChanged: (bool value) {
                                setState(() {
                                  isNotificationEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),

                      //  Other Box: contact us ,  Log out
                      Container(
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title of the Box
                            const Text(
                              'اخرى',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSizes.sm),
                            // Contact Us Item
                            ListTile(
                              leading: Image.asset(IconsPath.phoneIcon),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'تواصل معنا',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Image.asset(IconsPath.forwardArrowIcon,height: AppSizes.iconMd),
                                ],
                              ),
                              onTap: () {
                                // Handle tap
                              },
                            ),
                            // Log Out Item
                            ListTile(
                              leading: Image.asset(IconsPath.logoutIcon),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'سجل الخروج',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Image.asset(IconsPath.forwardArrowIcon,height: AppSizes.iconMd),
                                ],
                              ),
                              onTap: () {

                              },
                            ),
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
      ),
    );

  }
}
