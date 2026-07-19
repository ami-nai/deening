import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.grey900,
      ),
      scaffoldBackgroundColor: AppColors.grey50,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grey900,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyles.headlineSmall.copyWith(
          color: AppColors.grey900,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyles.displayLarge.copyWith(color: AppColors.grey900),
        displayMedium: TextStyles.displayMedium.copyWith(color: AppColors.grey900),
        displaySmall: TextStyles.displaySmall.copyWith(color: AppColors.grey900),
        headlineLarge: TextStyles.headlineLarge.copyWith(color: AppColors.grey900),
        headlineMedium: TextStyles.headlineMedium.copyWith(color: AppColors.grey900),
        headlineSmall: TextStyles.headlineSmall.copyWith(color: AppColors.grey900),
        titleLarge: TextStyles.titleLarge.copyWith(color: AppColors.grey900),
        titleMedium: TextStyles.titleMedium.copyWith(color: AppColors.grey700),
        titleSmall: TextStyles.titleSmall.copyWith(color: AppColors.grey700),
        bodyLarge: TextStyles.bodyLarge.copyWith(color: AppColors.grey900),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: AppColors.grey700),
        bodySmall: TextStyles.bodySmall.copyWith(color: AppColors.grey500),
        labelLarge: TextStyles.labelLarge.copyWith(color: AppColors.primary),
        labelMedium: TextStyles.labelMedium.copyWith(color: AppColors.grey600),
        labelSmall: TextStyles.labelSmall.copyWith(color: AppColors.grey500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyles.bodyMedium.copyWith(color: AppColors.grey400),
        labelStyle: TextStyles.labelLarge.copyWith(color: AppColors.grey700),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.grey300,
          disabledForegroundColor: AppColors.grey500,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.grey300,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyles.labelLarge,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.grey900,
        onSurface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.grey900,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.grey800,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyles.headlineSmall.copyWith(
          color: AppColors.white,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyles.displayLarge.copyWith(color: AppColors.white),
        displayMedium: TextStyles.displayMedium.copyWith(color: AppColors.white),
        displaySmall: TextStyles.displaySmall.copyWith(color: AppColors.white),
        headlineLarge: TextStyles.headlineLarge.copyWith(color: AppColors.white),
        headlineMedium: TextStyles.headlineMedium.copyWith(color: AppColors.white),
        headlineSmall: TextStyles.headlineSmall.copyWith(color: AppColors.white),
        titleLarge: TextStyles.titleLarge.copyWith(color: AppColors.white),
        titleMedium: TextStyles.titleMedium.copyWith(color: AppColors.grey300),
        titleSmall: TextStyles.titleSmall.copyWith(color: AppColors.grey300),
        bodyLarge: TextStyles.bodyLarge.copyWith(color: AppColors.white),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: AppColors.grey300),
        bodySmall: TextStyles.bodySmall.copyWith(color: AppColors.grey400),
        labelLarge: TextStyles.labelLarge.copyWith(color: AppColors.primary),
        labelMedium: TextStyles.labelMedium.copyWith(color: AppColors.grey400),
        labelSmall: TextStyles.labelSmall.copyWith(color: AppColors.grey500),
      ),
    );
  }
}
