// this page is for custom text theme
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'customTheme/text_theme.dart';
class AppTheme{
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      // fontFamily: 'Montserrat',
      // just to now that is light theme
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: AppTextTheme.lightTheme,
      );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: 'Montserrat',
    // just to now that is dark theme
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: AppTextTheme.darkTheme,
  );
}