import 'package:flutter/material.dart';
import 'package:plasess/constants/app_colors.dart';
import 'package:plasess/theme/app_typography.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary60,
    scaffoldBackgroundColor: AppColors.neutral10,
    textTheme: AppTypography.getTextTheme(false),
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
      primary: AppColors.primary60,
      secondary: AppColors.neutral70,
      surface: AppColors.primary10,
      onPrimary: Colors.white,
      onSurface: AppColors.neutral100,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary60,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neutral50),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neutral50),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary60, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.neutral70),
    ),
    iconTheme: const IconThemeData(color: AppColors.neutral70),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary10,
      iconTheme: IconThemeData(color: AppColors.neutral100),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.neutral100,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.neutral10,
      selectedItemColor: AppColors.primary60,
      unselectedItemColor: AppColors.neutral60,
      showUnselectedLabels: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary60,
      foregroundColor: Colors.white,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary90, // ✅ أزرق غامق
    scaffoldBackgroundColor: AppColors.neutral90,
    textTheme: AppTypography.getTextTheme(true),
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: AppColors.primary90, // ✅ أزرق غامق
      secondary: AppColors.neutral30,
      surface: const Color.fromARGB(255, 82, 114, 147),
      onPrimary: Colors.white,
      onSurface: AppColors.darkNeutral70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary90, // ✅ أزرق غامق
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral80,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neutral60),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neutral60),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary90, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.neutral30),
    ),
    iconTheme: const IconThemeData(color: AppColors.neutral20),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.neutral90,
      iconTheme: IconThemeData(color: AppColors.neutral20),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.neutral20,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.neutral90,
      selectedItemColor: AppColors.primary90, // ✅ أزرق غامق
      unselectedItemColor: AppColors.neutral50,
      showUnselectedLabels: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary90, // ✅ أزرق غامق
      foregroundColor: Colors.white,
    ),
  );
}
