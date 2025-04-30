import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/colors.dart';
import '../styles/radius.dart';
import '../styles/typography.dart';
import '../enums/app_enums.dart';

/// App theme configuration
class AppTheme {
  // Singleton instance
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  // Current theme mode
  AppThemeMode _themeMode = AppThemeMode.system;

  /// Get current theme mode
  AppThemeMode get themeMode => _themeMode;

  /// Set theme mode
  void setThemeMode(AppThemeMode mode) {
    _themeMode = mode;
  }

  /// Get theme mode as Flutter's ThemeMode
  ThemeMode getThemeMode() {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Get light theme
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColors.surface,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: AppTypography.h6,
      ),
      textTheme: _buildTextTheme(),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.mdRadius,
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  /// Get dark theme
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.gray900,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: AppColors.gray800,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.primary300),
        titleTextStyle: AppTypography.h6.copyWith(color: AppColors.white),
      ),
      textTheme: _buildTextTheme(isDark: true),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.mdRadius,
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: AppColors.gray800,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.gray800,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.gray600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.gray600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.primary400),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  /// Build text theme
  TextTheme _buildTextTheme({bool isDark = false}) {
    final Color textColor = isDark ? AppColors.white : AppColors.textPrimary;
    final Color textSecondaryColor =
        isDark ? AppColors.gray300 : AppColors.textSecondary;

    return TextTheme(
      displayLarge: AppTypography.h1.copyWith(color: textColor),
      displayMedium: AppTypography.h2.copyWith(color: textColor),
      displaySmall: AppTypography.h3.copyWith(color: textColor),
      headlineMedium: AppTypography.h4.copyWith(color: textColor),
      headlineSmall: AppTypography.h5.copyWith(color: textColor),
      titleLarge: AppTypography.h6.copyWith(color: textColor),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTypography.bodySmall.copyWith(color: textSecondaryColor),
      labelLarge: AppTypography.buttonLarge.copyWith(color: textColor),
      labelMedium: AppTypography.buttonMedium.copyWith(color: textColor),
      labelSmall: AppTypography.buttonSmall.copyWith(color: textColor),
    );
  }
}
