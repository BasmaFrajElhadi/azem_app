import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

// Primary and secondary colors
  static const Color primaryColor = Color(0xFF7695FF); // Deep Blue
  static const Color secondaryColor = Color(0xFFFF9874); // Coral (now the secondary color)
  static const Color accentLightBlue = Color(0xFF9DBDFF); // Light Blue
  static const Color accentPeach = Color(0xFFFFD7C4); // Peach

  // Neutral Colors (Grayscale)
  static const Color white = Color(0xFFFFFFFF); // Pure White
  static const Color black = Color(0xFF000000); // Pure Black
  static const Color lightGray = Color(0xFFF5F5F5); // Very Light Gray
  static const Color mediumLightGray = Color(0xFFE0E0E0); // Light-Medium Gray
  static const Color mediumGray = Color(0xFFBDBDBD); // Medium Gray
  static const Color gray = Color(0xFF9E9E9E); // Neutral Gray
  static const Color slateGray = Color(0xFF757575); // Slate Gray
  static const Color mediumDarkGray = Color(0xFF616161); // Darker Gray
  static const Color darkGray = Color(0xFF424242); // Dark Gray
  static const Color veryDarkGray = Color(0xFF212121); // Very Dark Gray

  // Background Colors
  static const Color backgroundLight = Color(0xFFF7F7F7); // Light background
  static const Color backgroundDark = Color(0xFF303030); // Dark background

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Primary text (Dark)
  static const Color textSecondary = Color(0xFF757575); // Secondary text (Gray)
  static const Color textHint = Color(0xFFBDBDBD); // Hint text (Lighter Gray)

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0); // Light gray border
  static const Color borderDark = Color(0xFF424242); // Dark gray border

  // Custom Thematic Colors
  static const Color successColor = Color(0xFF4CAF50); // Green (Success)
  static const Color warningColor = Color(0xFFFFC107); // Amber (Warning)
  static const Color errorColor = Color(0xFFF44336); // Red (Error)
  static const Color infoColor = Color(0xFF2196F3); // Blue (Info)

  // Gradient Colors (optional)
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6D5DFB), Color(0xFF4B68FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFFE24B), Color(0xFFFFC107)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
