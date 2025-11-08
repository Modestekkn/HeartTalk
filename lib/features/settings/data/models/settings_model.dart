
class SettingsModel {
  final bool isDarkMode;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final int defaultTopicDuration; // en secondes
  final bool hasSeenOnboarding;

  const SettingsModel({
    this.isDarkMode = false,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.defaultTopicDuration = 300,
    this.hasSeenOnboarding = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'isDarkMode': isDarkMode,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'defaultTopicDuration': defaultTopicDuration,
      'hasSeenOnboarding': hasSeenOnboarding,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      isDarkMode: map['isDarkMode'] as bool? ?? false,
      soundEnabled: map['soundEnabled'] as bool? ?? true,
      vibrationEnabled: map['vibrationEnabled'] as bool? ?? true,
      defaultTopicDuration: map['defaultTopicDuration'] as int? ?? 300,
      hasSeenOnboarding: map['hasSeenOnboarding'] as bool? ?? false,
    );
  }

  SettingsModel copyWith({
    bool? isDarkMode,
    bool? soundEnabled,
    bool? vibrationEnabled,
    int? defaultTopicDuration,
    bool? hasSeenOnboarding,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      defaultTopicDuration: defaultTopicDuration ?? this.defaultTopicDuration,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}