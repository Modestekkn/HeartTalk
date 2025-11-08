import 'package:flutter/cupertino.dart';
import 'package:heartalk/features/category/presentation/category_selection_screen.dart';
import 'package:heartalk/features/onboarding/presentation/onboarding_screen.dart';
import 'package:heartalk/features/splash/presentation/splash_screen.dart';

class AppRouter {
  AppRouter._();
  static Map<String, Widget Function(BuildContext)> myroutes = {
    splash : (context) => SplashScreen(),
    onboarding : (context) => OnboardingScreen(),
    category : (context) => CategorySelectionScreen(),
  };

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String category = '/category';
}
