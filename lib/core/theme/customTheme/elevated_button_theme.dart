import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class AppElevateButtonTheme{
  AppElevateButtonTheme._();

  //light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      disabledForegroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.mediumGray,
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: AppSizes.fontSizeMd,color:Colors.white,fontWeight: FontWeight.w600),
    ),
  );

  //dark theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  elevation: 0,
  foregroundColor: Colors.white,
  backgroundColor: AppColors.primaryColor,
  disabledForegroundColor: AppColors.white,
  disabledBackgroundColor: AppColors.mediumGray,
  padding: const EdgeInsets.symmetric(vertical: 18),
  textStyle: const TextStyle(fontSize: AppSizes.fontSizeMd,color:Colors.white,fontWeight: FontWeight.w600),
  ));
}