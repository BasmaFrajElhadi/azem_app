import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class WorkoutTabBar extends StatefulWidget {
  const WorkoutTabBar({super.key});

  @override
  _WorkoutTabBarState createState() => _WorkoutTabBarState();
}

class _WorkoutTabBarState extends State<WorkoutTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      // تحديث واجهة المستخدم عند تغيير التبويب
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
                      ? AppColors.primaryColor // تطبيق اللون الأساسي إذا تم اختيار التبويب
                      : AppColors.mediumLightGray, // تطبيق اللون الرمادي إذا لم يتم اختيار التبويب
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
        return 'تمارين القلب';
      case 1:
        return 'القوة';
      case 2:
        return 'المرونة';
      case 3:
        return 'HIIT';
      case 4:
        return 'اليوغا';
      default:
        return '';
    }
  }
}
