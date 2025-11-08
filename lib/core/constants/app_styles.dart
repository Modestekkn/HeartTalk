import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Styles de texte et autres styles globaux
class AppStyles {
  // constructeur privé
  AppStyles._();

  // ============ TYPOGRAPHIE ============

  /// Display (48px, Bold) - Pour splash screen
  static TextStyle display({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: fontweight ?? FontWeight.bold,
        height: 1.2,
        color: color ?? AppColors.textLight,
      );

  /// Heading 1 (32px, Bold) - Titres principaux
  static TextStyle h1({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: fontweight ?? FontWeight.bold,
        height: 1.3,
        color: color ?? AppColors.textLight,
      );

  /// Heading 2 (28px, SemiBold) - Sous-titres
  static TextStyle h2({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: fontweight ?? FontWeight.w600,
        height: 1.3,
        color: color ?? AppColors.textLight,
      );

  /// Heading 3 (24px, SemiBold) - Titres de cartes
  static TextStyle h3({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: fontweight ?? FontWeight.w600,
        height: 1.4,
        color: color ?? AppColors.textLight,
      );

  /// Heading 4 (20px, Medium) - Sous-titres de cartes
  static TextStyle h4({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: fontweight ?? FontWeight.w500,
        height: 1.4,
        color: color ?? AppColors.textLight,
      );

  /// Body Large (18px, Regular) - Texte important
  static TextStyle bodyLarge({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: fontweight ?? FontWeight.w400,
        height: 1.5,
        color: color ?? AppColors.textLight,
      );

  /// Body (16px, Regular) - Texte standard
  static TextStyle body({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: fontweight ?? FontWeight.w400,
        height: 1.5,
        color: color ?? AppColors.textLight,
      );

  /// Body Small (14px, Regular) - Descriptions
  static TextStyle bodySmall({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: fontweight ?? FontWeight.w400,
        height: 1.5,
        color: color ?? AppColors.textSecondary,
      );

  /// Caption (12px, Regular) - Textes très petits
  static TextStyle caption({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: fontweight ?? FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.textSecondary,
      );

  /// Button (16px, SemiBold) - Texte des boutons
  static TextStyle button({Color? color, FontWeight? fontweight}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: fontweight ?? FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.5,
        color: color ?? AppColors.white,
      );

  // ============ ESPACEMENTS ============
  static const double space0 = 0;
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space8 = 32;
  static const double space10 = 40;
  static const double space12 = 48;
  static const double space16 = 64;

  // ============ BORDER RADIUS ============
  static const double radiusSm = 8;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusXl = 32;
  static const double radiusFull = 9999;

  static BorderRadius borderSm = BorderRadius.circular(radiusSm);
  static BorderRadius borderMd = BorderRadius.circular(radiusMd);
  static BorderRadius borderLg = BorderRadius.circular(radiusLg);
  static BorderRadius borderXl = BorderRadius.circular(radiusXl);
  static BorderRadius borderFull = BorderRadius.circular(radiusFull);

  // ============ OMBRES ============
  static List<BoxShadow> shadowSm = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 2)),
  ];

  static List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> shadow2xl = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 48,
      offset: const Offset(0, 20),
    ),
  ];

  // ============ GLASSMORPHISM DECORATION ============
  static BoxDecoration glassDecoration({
    Gradient? gradient,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return BoxDecoration(
      gradient: gradient ?? AppColors.neutreGradient,
      borderRadius: borderRadius ?? borderMd,
      border: border ?? Border.all(color: AppColors.textLight, width: 4),
      boxShadow: shadowLg,
    );
  }

  // ============ BUTTON STYLES ============
  static BoxDecoration primaryButtonDecoration(Gradient gradient) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: borderMd,
      boxShadow: shadowLg,
    );
  }

  static BoxDecoration secondaryButtonDecoration(Color borderColor) {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: borderColor, width: 2),
      borderRadius: borderMd,
    );
  }

  // ============ INPUT DECORATION ============
  static InputDecoration inputDecoration({
    required String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: body(color: AppColors.textSecondary.withValues(alpha: 0.5)),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.glassMorphism,
      border: OutlineInputBorder(
        borderRadius: borderMd,
        borderSide: BorderSide(color: AppColors.glassBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderMd,
        borderSide: BorderSide(color: AppColors.glassBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderMd,
        borderSide: const BorderSide(
          color: AppColors.amoureuxPrimary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderMd,
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.all(space4),
    );
  }

  // ============ DURATIONS ============
  static const Duration durationMiniShort = Duration(milliseconds: 1800);
  static const Duration durationShort = Duration(milliseconds: 3000);
  static const Duration durationMedium = Duration(milliseconds: 4000);
  static const Duration durationLong = Duration(milliseconds: 5000);
  static const Duration durationXLong = Duration(milliseconds: 6000);

  // ============ CURVES ============
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveBounce = Curves.bounceOut;
}
