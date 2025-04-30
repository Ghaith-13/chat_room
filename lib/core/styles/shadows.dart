import 'package:flutter/material.dart';
import 'colors.dart';

/// App shadow constants
class AppShadows {
  // Elevation shadows
  static final List<BoxShadow> sm = [
    BoxShadow(
      color: AppColors.gray900.withOpacity(0.05),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static final List<BoxShadow> md = [
    BoxShadow(
      color: AppColors.gray900.withOpacity(0.07),
      blurRadius: 6,
      offset: const Offset(0, 3),
    ),
  ];

  static final List<BoxShadow> lg = [
    BoxShadow(
      color: AppColors.gray900.withOpacity(0.1),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> xl = [
    BoxShadow(
      color: AppColors.gray900.withOpacity(0.1),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];

  static final List<BoxShadow> xxl = [
    BoxShadow(
      color: AppColors.gray900.withOpacity(0.1),
      blurRadius: 32,
      offset: const Offset(0, 16),
    ),
  ];
}
