import 'package:flutter/cupertino.dart';
import 'package:heartalk/features/category/presentation/category_selection_screen.dart';
import 'package:heartalk/features/onboarding/presentation/onboarding_screen.dart';
import 'package:heartalk/features/splash/presentation/splash_screen.dart';
import 'package:heartalk/features/players/presentation/player_input_screen.dart';
import 'package:heartalk/features/game/presentation/game_selection_screen.dart';
import 'package:heartalk/features/game/presentation/question_display_screen.dart';
import 'package:heartalk/features/game/presentation/topic_timer_screen.dart';
import 'package:heartalk/features/settings/presentation/settings_screen.dart';

class AppRouter {
  AppRouter._();

  static Map<String, Widget Function(BuildContext)> myroutes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    category: (context) => const CategorySelectionScreen(),
    playerInput: (context) => const PlayerInputScreen(),
    gameSelection: (context) => const GameSelectionScreen(),
    questionDisplay: (context) => const QuestionDisplayScreen(),
    topicTimer: (context) => const TopicTimerScreen(),
    settings: (context) => const SettingsScreen(),
  };

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String category = '/category';
  static const String playerInput = '/player-input';
  static const String gameSelection = '/game-selection';
  static const String questionDisplay = '/question-display';
  static const String topicTimer = '/topic-timer';
  static const String settings = '/settings';
}
