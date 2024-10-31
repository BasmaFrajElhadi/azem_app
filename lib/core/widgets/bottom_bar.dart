import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import '../../features/user/analytics/presentation/pages/analysis_screen.dart';
import '../../features/user/expert/presentation/pages/experts_screen.dart';
import '../../features/user/home/presentation/pages/home_screen.dart';
import '../../features/user/nutrition/presentation/pages/meals.dart';
import '../../features/user/userManagement/presentation/pages/user_profile.dart';
import '../../features/user/wokout/presentation/pages/workout_calculator.dart';
import '../constants/colors.dart';

class CustomBottomBar extends StatefulWidget {
  final Widget child;

  const CustomBottomBar({super.key, required this.child});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExpertScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnalysisScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfileScreen()),
        );
        break;
    }
  }

  // Method to show the input dialog
  void _showInputDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set the dialog background color
          title: const Text(
            textAlign: TextAlign.right,
            'ادخل وزنك',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl, // Set text direction to RTL
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "اضف وزنك الجديد...",
                    hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Add button
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Primary color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              onPressed: () {
                String input = controller.text;
                if (input.isNotEmpty) {
                  // Handle the input (e.g., convert to double)
                  double number = double.tryParse(input) ?? 0.0;
                  print("Entered weight: $number");
                  // Handle the input as needed
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'اضف', // Button text
                style: TextStyle(color: Colors.white), // White text
              ),
            ),
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'الغاء',
                style: TextStyle(color: AppColors.primaryColor), // Cancel button text
              ),
            ),
          ],
        );
      },
    );
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
              icon: Icons.explore,
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
              icon: const Icon(Icons.fastfood_rounded, color: AppColors.mediumGray),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealsScreen()),
                );
              },
            ),
            SCItem(
              icon: const Icon(Icons.scale_rounded, color: AppColors.mediumGray),
              onPressed: () {
                _showInputDialog(); // Open the dialog
              },
            ),
            SCItem(
              icon: const Icon(Icons.directions_run_rounded, color: AppColors.mediumGray),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WorkoutCalculatorScreen()),
                );
              },
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
