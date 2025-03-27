import 'package:cutfx/screens/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextStyles {
  

  static TextStyle body = GoogleFonts.figtree(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static TextStyle bodyBold = GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle button = GoogleFonts.figtree(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle sectionTitle = GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle specialistName = GoogleFonts.urbanist(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle specialistRole = GoogleFonts.figtree(
    fontSize: 10,
    color: AppColors.textTertiary,
  );
}