import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class ExpertTabBar extends StatefulWidget {
  const ExpertTabBar({super.key});

  @override
  _ExpertTabBarState createState() => _ExpertTabBarState();
}

class _ExpertTabBarState extends State<ExpertTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      length: 3,
      child: Container(
        color: AppColors.backgroundLight,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: AppColors.textPrimary,
          labelColor: AppColors.white,
          labelPadding: const EdgeInsets.symmetric(horizontal: 10),
          indicator: const BoxDecoration(
            color: Colors.transparent,
          ),
          tabs: List.generate(3, (index) {
            return Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.lg),
                decoration: BoxDecoration(
                  color: _tabController.index == index
                      ? AppColors.primaryColor // Apply primary color if selected
                      : AppColors.mediumLightGray, // Apply grey if unselected
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getTabTitle(index),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
        return 'الكل';
      case 1:
        return 'المدربين';
      case 2:
        return 'الأخصائيين';
      default:
        return '';
    }
  }
}
