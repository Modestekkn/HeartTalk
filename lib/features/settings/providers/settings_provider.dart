import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/settings_model.dart';

// ============================================
// SETTINGS NOTIFIER
// ============================================
class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier() : super(const SettingsModel()) {
    _loadSettings();
  }

  static const String _keyDarkMode = 'isDarkMode';
  static const String _keySound = 'soundEnabled';
  static const String _keyVibration = 'vibrationEnabled';
  static const String _keyDuration = 'defaultTopicDuration';
  static const String _keyOnboarding = 'hasSeenOnboarding';

  // Charger les paramètres depuis SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    state = SettingsModel(
      isDarkMode: prefs.getBool(_keyDarkMode) ?? false,
      soundEnabled: prefs.getBool(_keySound) ?? true,
      vibrationEnabled: prefs.getBool(_keyVibration) ?? true,
      defaultTopicDuration: prefs.getInt(_keyDuration) ?? 300,
      hasSeenOnboarding: prefs.getBool(_keyOnboarding) ?? false,
    );
  }

  // Toggle dark mode
  Future<void> toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.isDarkMode;
    await prefs.setBool(_keyDarkMode, newValue);
    state = state.copyWith(isDarkMode: newValue);
  }

  // Toggle sound
  Future<void> toggleSound() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.soundEnabled;
    await prefs.setBool(_keySound, newValue);
    state = state.copyWith(soundEnabled: newValue);
  }

  // Toggle vibration
  Future<void> toggleVibration() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.vibrationEnabled;
    await prefs.setBool(_keyVibration, newValue);
    state = state.copyWith(vibrationEnabled: newValue);
  }

  // Mettre à jour la durée par défaut des sujets
  Future<void> updateDefaultDuration(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyDuration, seconds);
    state = state.copyWith(defaultTopicDuration: seconds);
  }

  // Marquer l'onboarding comme vu
  Future<void> markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboarding, true);
    state = state.copyWith(hasSeenOnboarding: true);
  }

  // Réinitialiser tous les paramètres
  Future<void> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = const SettingsModel();
  }
}

// ============================================
// PROVIDER
// ============================================
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsModel>(
  (ref) => SettingsNotifier(),
);

// ============================================
// HELPER PROVIDERS
// ============================================

// Provider pour savoir si l'onboarding a été vu
final hasSeenOnboardingProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).hasSeenOnboarding;
});

// Provider pour le mode sombre
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).isDarkMode;
});

// Provider pour le son
final isSoundEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).soundEnabled;
});

// Provider pour la vibration
final isVibrationEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).vibrationEnabled;
});
