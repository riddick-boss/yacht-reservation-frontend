import 'package:flutter/material.dart';

/// Centralized color definitions
///
/// Use these static fields for consistent color usage across the app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary brand color (e.g., for AppBar, buttons)
  static const Color primary = Color(0xFF005B96);

  // Accent color (e.g., for highlights, interactive elements)
  static const Color accent = Color(0xFFFFC107);

  // Secondary color (e.g., for less prominent actions)
  static const Color secondary = Color(0xFF0077B6);

  // Background color for screens
  static const Color background = Color(0xFFF5F5F5);

  // Surface color for cards, bottom sheets, etc.
  static const Color surface = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // Success, warning, error
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);

  // Divider color
  static const Color divider = Color(0xFFBDBDBD);

  // Custom yacht-theme specific colors
  static const Color oceanBlue = Color(0xFF0077BE);
  static const Color sailWhite = Color(0xFFF0F8FF);
  static const Color teakBrown = Color(0xFF8B4513);
}
