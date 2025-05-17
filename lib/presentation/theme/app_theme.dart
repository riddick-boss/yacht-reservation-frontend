import 'package:flutter/material.dart';
import 'package:yacht_reservation_frontend/presentation/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.oceanBlue,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.sailWhite,
        onSecondary: AppColors.sailWhite,
        onSurface: AppColors.textPrimary,
        onError: AppColors.sailWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.oceanBlue,
        foregroundColor: AppColors.sailWhite,
      ),
    );
  }
}
