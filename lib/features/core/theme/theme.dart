import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xfff3d20f);
  static const surface = Color(0xFFF0F2F5);
  static const onSurface = Color(0xFF1E1E1E);
  static const textPrimary = Color(0xff000000);
  static const appBarTitle = Color(0xff2e1903);
  static const textSecondary = Color(0xFF777F8D);
  static const scaffoldBg = Color(0xffffffff);
  static const disabledBg = Color(0xffffffff);
}

final themeData = ThemeData(
  primaryColor: AppColors.primary,

  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    surface: AppColors.surface,
    onPrimary: AppColors.textPrimary,
    onSurface: AppColors.textSecondary,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.textPrimary,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontSize: 21,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),

  scaffoldBackgroundColor: Color(0xffffffff),
  appBarTheme: AppBarTheme(
    color: AppColors.primary,
    foregroundColor: AppColors.appBarTitle,
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textPrimary),
      borderRadius: BorderRadius.circular(14),
    ),
    contentPadding: EdgeInsets.all(16),
    hintStyle: GoogleFonts.golosText(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.textPrimary,
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Color(0xffffffff); // цвет для disabled
        }
        return AppColors.primary; // активный цвет
      }),

      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.textSecondary; // цвет текста на серой кнопке
        }
        return Color(0xFF000000);
      }),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        return GoogleFonts.inter();
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
  ),
);
