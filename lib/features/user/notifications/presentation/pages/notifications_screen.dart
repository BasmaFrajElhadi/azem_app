import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/strings/info.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) {
    bool isThereNotification = true;

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
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.6),  // Reduced opacity for stronger effect
                        Colors.white.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // Glassmorphism effect (Blurred background)
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 30,
                    sigmaY: 30,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.3),  // Lower opacity for a more transparent look
                  ),
                ),

                // Content of the screen
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
                  child: ListView(
                    children: [
                      const TextAppBar(title: 'الإشعارات'),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),

                      // Conditional rendering based on isThereNotification
                      if (isThereNotification) ...[
                        const NotificationItem(text: 'لا تفوت الفرصة! استمتع بخصم 20% على استشارات التغذية وخطط التدريب لهذا الإسبوع. \n احجز الان و استفد من العرض المميز!'),
                        const NotificationItem(text: 'لا تفوت الفرصة! استمتع بخصم 20% على استشارات التغذية وخطط التدريب لهذا الإسبوع. \n احجز الان و استفد من العرض المميز!'),
                        const NotificationItem(text: 'لا تفوت الفرصة! استمتع بخصم 20% على استشارات التغذية وخطط التدريب لهذا الإسبوع. \n احجز الان و استفد من العرض المميز!'),
                        const NotificationItem(text: 'لا تفوت الفرصة! استمتع بخصم 20% على استشارات التغذية وخطط التدريب لهذا الإسبوع. \n احجز الان و استفد من العرض المميز!'),
                      ] else ...[
                        // No notifications container
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(IconsPath.noNotificationIcon, height: 100),
                              const SizedBox(height: AppSizes.md),
                              const Text(
                                AppInfo.messageNoNotifications,
                                style: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: AppSizes.fontSizeXl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
