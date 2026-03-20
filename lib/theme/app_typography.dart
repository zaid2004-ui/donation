import 'package:flutter/material.dart';
import 'package:plasess/constants/app_colors.dart';
import 'package:plasess/theme/app_size.dart';

class AppTypography {
  static TextTheme getTextTheme(bool isDark) => TextTheme(
    headlineLarge: TextStyle(
      fontSize: AppSize.heading1,
      height: AppSize.lineHeightHeading1 / AppSize.heading1,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    headlineMedium: TextStyle(
      fontSize: AppSize.heading2,
      height: AppSize.lineHeightHeading2 / AppSize.heading2,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    headlineSmall: TextStyle(
      fontSize: AppSize.heading3,
      height: AppSize.lineHeightHeading3 / AppSize.heading3,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    titleLarge: TextStyle(
      fontSize: AppSize.heading4,
      height: AppSize.lineHeightHeading4 / AppSize.heading4,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    titleMedium: TextStyle(
      fontSize: AppSize.heading5,
      height: AppSize.lineHeightHeading5 / AppSize.heading5,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral20 : AppColors.neutral90,
    ),

    bodyLarge: TextStyle(
      fontSize: AppSize.largeText,
      height: AppSize.lineHeightLargeText / AppSize.largeText,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    bodyMedium: TextStyle(
      fontSize: AppSize.mediumText,
      height: AppSize.lineHeightMediumText / AppSize.mediumText,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    bodySmall: TextStyle(
      fontSize: AppSize.smallText,
      height: AppSize.lineHeightSmallText / AppSize.smallText,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral30 : AppColors.neutral70,
    ),

    labelLarge: TextStyle(
      fontSize: AppSize.mediumText,
      height: AppSize.lineHeightMediumText / AppSize.mediumText,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral10 : AppColors.neutral100,
    ),

    labelMedium: TextStyle(
      fontSize: AppSize.smallText,
      height: AppSize.lineHeightSmallText / AppSize.smallText,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkNeutral30 : AppColors.neutral70,
    ),

    labelSmall: TextStyle(
      fontSize: AppSize.xSmallText,
      height: AppSize.lineHeightXSmallText / AppSize.xSmallText,
      fontWeight: FontWeight.w400,
      color: isDark ? AppColors.darkNeutral40 : AppColors.neutral60,
    ),
  );
}
