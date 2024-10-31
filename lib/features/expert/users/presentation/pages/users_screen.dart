import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../../../../user/expert/presentation/provider/subscription_provider.dart';
import '../../../../user/userManagement/presentation/provider/current_user_provider.dart';
import '../widgets/user_grid_view.dart';
import '../widgets/user_search_bar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    // Fetch subscriptions when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SubscriptionProvider>(context, listen: false);
      final currentUserProvider = Provider.of<CurrentUserProvider>(context, listen: false);
      provider.fetchSubscriptionsByExpert(currentUserProvider.email);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  child: Column(
                    children: [
                      const TextAppBar(title: "مشتركين"),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const Text(
                        "مشتركو تطبيقنا أمانة بين يديك، يسعون نحو حياة أكثر صحة وتوازن. دورك كخبير في اللياقة والتغذية هو أن تكون داعمًا وموجهًا لهم في رحلتهم نحو الأفضل.",
                        style: TextStyle(
                          fontSize: AppSizes.fontSizeXs,
                          color: AppColors.textSecondary,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const UserSearchBar(),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // TabBar outside the AppBar
                      Container(
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          unselectedLabelColor: AppColors.textPrimary,
                          labelColor: AppColors.white,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          indicator: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          tabs: List.generate(2, (index) {
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
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // TabBarView to display the content for each tab
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Consumer<SubscriptionProvider>(
                              builder: (context, provider, child) {
                                // Display all subscription users
                                final allUsers = provider.usersInSubscription;
                                return UserGridView(
                                  userSubscriptionList: allUsers,
                                );
                              },
                            ),
                            Consumer<SubscriptionProvider>(
                              builder: (context, provider, child) {
                                // Filter and display new users with status 'pending'
                                final newUsers = provider.usersInSubscription
                                    .where((user) => user.status == 'pending')
                                    .toList();
                                return UserGridView(
                                  userSubscriptionList: newUsers, // Pass new users
                                );
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

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'الكل';
      case 1:
        return 'المشتركيين الجدد';
      default:
        return '';
    }
  }
}
