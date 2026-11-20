import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFFDB3A00);
  static const button = Color(0xFFFF5722);
  static const clearButton = Color(0xFF9E9E9E);
  static const resultBox = Color(0xFFC8E6C9);
  static const resultValue = Color(0xFFE53935);
  static const genderSelected = Color(0xFFB3E5FC);
  static const background = Color(0xFFFEF7FA);
  static const border = Color(0xFFBDBDBD);
  static const textDark = Color(0xFF212121);
  static const white = Colors.white;
}

class AppImages {
  AppImages._();

  static const calculator = 'assets/images/calculator.png';
  static const bmi = 'assets/images/bmi.png';
  static const bmr = 'assets/images/bmr.png';
  static const sauLogo = 'assets/images/sau_logo.png';
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
    );
    final radius = BorderRadius.circular(6);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.kanitTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
        titleTextStyle: GoogleFonts.kanit(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        hintStyle: GoogleFonts.kanit(fontSize: 15, color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: AppColors.button, width: 1.5),
        ),
        border: OutlineInputBorder(borderRadius: radius),
      ),
    );
  }
}
