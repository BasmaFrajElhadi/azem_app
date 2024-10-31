import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class MealsTabBar extends StatefulWidget {
  const MealsTabBar({super.key});

  @override
  _MealsTabBarState createState() => _MealsTabBarState();
}

class _MealsTabBarState extends State<MealsTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      // Update the UI when the tab changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        color: AppColors.backgroundLight,
        child: TabBar(
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
                      ? AppColors.primaryColor // Apply primary color if selected
                      : AppColors.mediumLightGray, // Apply grey if unselected
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(_getTabTitle(index)),
              ),
            );
          }),
        ),
      ),
    );
  }

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'لحوم';
      case 1:
        return 'فواكة';
      case 2:
        return 'خضروات';
      case 3:
        return 'مشروبات';
      case 4:
        return 'حلويات';
      default:
        return '';
    }
  }
}
