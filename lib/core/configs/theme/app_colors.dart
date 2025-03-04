import 'package:flutter/material.dart';
import 'package:tastytable/features/settings/presentation/cubit/theme_cubit.dart';

class AppColors {
  static bool get isDark => ThemeCubit.instance.isDarkMode();

  // Primary
  static Color get primary => isDark ? Colors.black : Colors.white;

  // Auth
  static const Color authSignInButtonBackgroundColor = Color(0xFFfabb36);
  static Color get authSignInButtonTextColor =>
      isDark ? Colors.black : Colors.white;

  // Recipe
  static const Color recipeSearchIconColor = Colors.white;
  static Color get recipeSearchIconContainerColor =>
      isDark ? Colors.green.shade700 : Colors.green.shade300;
  static Color get recipeSettingsIconColor =>
      isDark ? Colors.white : Colors.black;
  static Color get recipeSettingsIconBackgroundColor =>
      isDark ? Colors.grey.shade700 : Colors.grey.shade300;
  static Color get recipeViewAllTextColor =>
      isDark ? Colors.white : Colors.black;
  static const Color recipeFoodTitleColor = Colors.white;
  static Color get recipePopUpCancelTextColor =>
  isDark? Colors.white:Colors.black;

  // Shimmer
  static Color get shimmerBaseColor =>
      isDark ? Colors.grey.shade700 : Colors.grey.shade300;
  static Color get shimmerHighlightColor =>
      isDark ? Colors.grey.shade500 : Colors.grey.shade100;
  static Color get shimmerContainerColor =>
      isDark ? Colors.black : Colors.white;

  // View All
  static const Color viewAllRecipeTitleColor = Colors.white;

  // Settings
  static const Color settingsSignoutBackgroundColor = Colors.red;
  static const Color  settingsSignoutForegroundColor = Colors.white;
  static const Color settingsUserNameIconColor = Colors.blue;

  // Settings TextField Border
  static Color get settingsCommonTextFeildBorderColor =>
      isDark ? Colors.white : Colors.black;

  // Delete Account
  static const Color deleteAccountContinueButtonBackgroundColor = Colors.green;
  static const Color deleteAccountContinueButtonForegroundColor = Colors.white;
  static Color get deleteConfirmAccountCircleAvatarBackgroundColor =>
      isDark ? Colors.white : Colors.black;
  static Color get deleteConfirmAccountCircleAvatarForegroundColor =>
      isDark ? Colors.black : Colors.white;
  static Color get deleteConfirmAccountBottomContainerColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade200;

  // Privacy & Policy
  static Color get privacyAndPolicyContainerBackgroundColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade200;
  static Color get privacyAndPolicyLockIconColor =>
      isDark ? Colors.white : Colors.grey;
  static Color get privacyAndPolicyOwnerTextColor =>
      isDark ? Colors.grey.shade500 : Colors.grey;
}
