import 'package:azem/features/expert/expertHome/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:spincircle_bottom_bar/modals.dart';

import '../../../../core/constants/colors.dart';
import '../../../user/nutrition/presentation/pages/meals.dart';
import '../../../user/wokout/presentation/pages/workout_calculator.dart';
import '../../expertManagement/presentation/pages/expert_profile.dart';
import '../../users/presentation/pages/users_screen.dart';


class ExpertBottomBar extends StatefulWidget {
  final Widget child;

  const ExpertBottomBar({super.key, required this.child});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<ExpertBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExpertHomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UsersScreen()),
        );
        break;
      case 2:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const AnalysisScreen()),
        // );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExpertProfileScreen()),
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
          circleColors: [
            AppColors.white,
            AppColors.primaryColor,
            AppColors.secondaryColor
          ],
          iconTheme: const IconThemeData(color: AppColors.mediumGray),
          activeIconTheme: const IconThemeData(color: AppColors.primaryColor),
          backgroundColor: Colors.white,
          titleStyle: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
          activeTitleStyle: const TextStyle(
              color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
          actionButtonDetails: SCActionButtonDetails(
            color: AppColors.primaryColor,
            icon: const Icon(Icons.add, color: AppColors.white),
            elevation: 2,
          ),
          elevation: 2.0,
          items: [
            SCBottomBarItem(
              icon: Icons.home_filled,
              title: "الرئيسية",
              onPressed: () => _onItemTapped(0),
            ),
            SCBottomBarItem(
              icon:  Icons.explore,
              title: "الخبراء",
              onPressed: () => _onItemTapped(1),
            ),
            SCBottomBarItem(
              icon: Icons.show_chart,
              title: "الاداء",
              onPressed: () => _onItemTapped(2),
            ),
            SCBottomBarItem(
              icon: Icons.person,
              title: "الحساب",
              onPressed: () => _onItemTapped(3),
            ),
          ],
          circleItems: [
            SCItem(
              icon: const Icon(Icons.fastfood_rounded,color:AppColors.mediumGray,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealsScreen()),
                );
              },
            ),
            SCItem(
              icon: const Icon(Icons.scale_rounded,color: AppColors.mediumGray),
              onPressed: () {

              },
            ),
            SCItem(
              icon: const Icon(Icons.directions_run_rounded,color: AppColors.mediumGray),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WorkoutCalculatorScreen()),
                );
              },
            ),
          ],
          // bnbHeight: 80,
        ),
        child: widget.child,
      ),
    );
  }
}
