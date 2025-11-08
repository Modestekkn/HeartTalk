import 'package:flutter/material.dart';

/// Couleurs de l'application HeartTalk
class AppColors {
  AppColors._();

  // ============ CATÉGORIE: EN COUPLE ============
  static const Color couplePrimary = Color(0xFFE63946);
  static const Color coupleSecondary = Color(0xFFFF6B9D);

  static const LinearGradient coupleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [couplePrimary, coupleSecondary],
  );

  // ============ CATÉGORIE: EN AMOUREUX ============
  static const Color amoureuxPrimary = Color(0xFF9B59B6);
  static const Color amoureuxSecondary = Color(0xFFFF6B9D);

  static const LinearGradient amoureuxGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [amoureuxPrimary, amoureuxSecondary],
  );

  // ============ CATÉGORIE: ENTRE AMI(E)S ==========
  static const Color amisPrimary = Color(0xFF4ECDC4);
  static const Color amisSecondary = Color(0xFF44A08D);

  static const LinearGradient amisGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [amisPrimary, amisSecondary],
  );

  // ============ CATÉGORIE: BACKGROUND ==========
  static const Color bgCategory = Color(0xFFFFCDCD);


  // ============ NEUTRE COLOR =============
  static const Color neutrePrimary = Color(0xFFFF37B6);
  static const Color neutreSecondary = Color(0xFFFF7B7B);

  static const LinearGradient neutreGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neutrePrimary, neutreSecondary],
  );

  // ============ SPLASH SCREEN ============
  static const Color bgWelcome = Color(0xFFFF3BA7);

  static const RadialGradient splashGradient = RadialGradient(
    center: Alignment(0.3, 0.5),
    radius: 1.0,
    colors: [
      amoureuxPrimary,
      amisPrimary,
      couplePrimary,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // ========== ASK AND TOPIC COLOR ===========
  static const Color coupleAskPrimary = Color(0xFFFFB222);
  static const Color coupleAskSecondary = Color(0xFFFF5025);

  static const LinearGradient coupleAskGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [coupleAskPrimary, coupleAskSecondary],
  );

  static const Color coupleTopicPrimary = Color(0xFFDD0060);
  static const Color coupleTopicSecondary = Color(0xFFFF4A4A);

  static const LinearGradient coupleTopicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [coupleTopicPrimary, coupleTopicSecondary],
  );


  static const Color loversAskPrimary = Color(0xFFFFBB00);
  static const Color loversAskSecondary = Color(0xFF5400BA);

  static const LinearGradient lorversAskGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [loversAskPrimary, loversAskSecondary],
  );

  static const Color loversTopicPrimary = Color(0xFF8725FF);
  static const Color loversTopicSecondary = Color(0xFFFF00D0);

  static const LinearGradient lorversTopicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [loversTopicPrimary, loversTopicSecondary],
  );


  static const Color friendsAskPrimary = Color(0xFFFFBF33);
  static const Color friendsAskSecondary = Color(0xFF00A5C2);

  static const LinearGradient friendsAskGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [friendsAskPrimary, friendsAskSecondary],
  );

  static const Color friendsTopicPrimary = Color(0xFF27FFF0);
  static const Color friendsTopicSecondary = Color(0xFF0060A4);

  static const LinearGradient friendsTopicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [friendsTopicPrimary, friendsTopicSecondary],
  );

  // ============ BACKGROUND GAME START ============
  static const Color gameStartPrimary = Color(0xFFA20059);
  static const Color gameStartSecondary = Color(0xFFFF006F);

  static const LinearGradient gameStartGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gameStartPrimary, gameStartSecondary],
    stops: [0, 100.0]
  );

  // ============ COULEURS NEUTRES ============
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF7F7F7);
  static const Color backgroundDark = Color(0xFF1A1A1A);


  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFFFFFFF);

  static const Color grey100 = Color(0xFFF7F7F7);
  static const Color grey200 = Color(0xFFECF0F1);
  static const Color grey300 = Color(0xFFD1D5D8);
  static const Color grey400 = Color(0xFFBDC3C7);
  static const Color grey800 = Color(0xFF2C3E50);
  static const Color grey900 = Color(0xFF1A1A1A);

  // ============ COULEURS SYSTÈME ============
  static const Color success = Color(0xFF27AE60);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);

  // ============ GLASSMORPHISM ============
  static Color glassMorphism = Colors.white70;
  static Color glassMorphismDark = Colors.white10;
  static Color glassBorder = Colors.white30;

  // ============ HELPER: Obtenir le gradient par catégorie ============
  static LinearGradient getGradientByCategory(String categoryId) {
    switch (categoryId) {
      case 'couple':
        return coupleGradient;
      case 'amoureux':
        return amoureuxGradient;
      case 'amis':
        return amisGradient;
      default:
        return amoureuxGradient;
    }
  }

  static Color getPrimaryByCategory(String categoryId) {
    switch (categoryId) {
      case 'couple':
        return couplePrimary;
      case 'amoureux':
        return amoureuxPrimary;
      case 'amis':
        return amisPrimary;
      default:
        return amoureuxPrimary;
    }
  }

  static Color getSecondaryByCategory(String categoryId) {
    switch (categoryId) {
      case 'couple':
        return coupleSecondary;
      case 'amoureux':
        return amoureuxSecondary;
      case 'amis':
        return amisSecondary;
      default:
        return amoureuxSecondary;
    }
  }
}