import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ============================================
// TIMER STATE
// ============================================
class TimerState {
  final int duration; // Durée totale en secondes
  final int remaining; // Temps restant en secondes
  final bool isRunning;
  final bool isFinished;

  const TimerState({
    required this.duration,
    required this.remaining,
    this.isRunning = false,
    this.isFinished = false,
  });

  double get progress => remaining / duration;
  bool get isWarning => remaining <= 30 && remaining > 10;
  bool get isCritical => remaining <= 10 && remaining > 0;

  String get displayTime {
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({
    int? duration,
    int? remaining,
    bool? isRunning,
    bool? isFinished,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
      isRunning: isRunning ?? this.isRunning,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

// ============================================
// TIMER NOTIFIER
// ============================================
class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier(int duration)
    : super(TimerState(duration: duration, remaining: duration));

  Timer? _timer;
  int _lastVibrationSecond = -1;

  // Démarrer le timer
  void start() {
    if (state.isRunning || state.isFinished) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remaining <= 0) {
        _finish();
        return;
      }

      final newRemaining = state.remaining - 1;
      state = state.copyWith(remaining: newRemaining);

      // Vibrations et feedback
      _handleFeedback(newRemaining);
    });
  }

  // Mettre en pause
  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  // Reprendre
  void resume() {
    if (!state.isRunning && !state.isFinished) {
      start();
    }
  }

  // Arrêter et réinitialiser
  void stop() {
    _timer?.cancel();
    state = TimerState(
      duration: state.duration,
      remaining: state.duration,
      isRunning: false,
      isFinished: false,
    );
    _lastVibrationSecond = -1;
  }

  // Terminer le timer
  void _finish() {
    _timer?.cancel();
    state = state.copyWith(remaining: 0, isRunning: false, isFinished: true);

    // Triple vibration forte pour signaler la fin
    _vibrateEnd();
  }

  // Terminer manuellement avant la fin
  void finishEarly() {
    _finish();
  }

  // Gérer les feedbacks (vibration) selon le temps restant
  void _handleFeedback(int remaining) {
    // Éviter les vibrations répétées pour la même seconde
    if (_lastVibrationSecond == remaining) return;
    _lastVibrationSecond = remaining;

    if (remaining <= 10 && remaining > 0) {
      // Vibration forte chaque seconde < 10s
      HapticFeedback.heavyImpact();
    } else if (remaining == 30) {
      // Vibration moyenne à 30s
      HapticFeedback.mediumImpact();
    }
  }

  // Triple vibration pour la fin
  void _vibrateEnd() {
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 200), () {
      HapticFeedback.heavyImpact();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      HapticFeedback.heavyImpact();
    });
  }

  // Ajouter du temps (bonus)
  void addTime(int seconds) {
    if (!state.isFinished) {
      state = state.copyWith(
        remaining: state.remaining + seconds,
        duration: state.duration + seconds,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// ============================================
// PROVIDERS
// ============================================

// Timer provider avec durée par défaut
final timerProvider = StateNotifierProvider.autoDispose
    .family<TimerNotifier, TimerState, int>((ref, duration) {
      return TimerNotifier(duration);
    });

// Provider pour créer un timer avec la durée depuis settings
final createTimerProvider = Provider.autoDispose<TimerNotifier>((ref) {
  // TODO: Récupérer la durée depuis settings
  const defaultDuration = 300; // 5 minutes par défaut
  return TimerNotifier(defaultDuration);
});

// ============================================
// HELPER PROVIDERS
// ============================================

// Vérifier si le timer est en cours
final isTimerRunningProvider = Provider.family<bool, int>((ref, duration) {
  return ref.watch(timerProvider(duration)).isRunning;
});

// Vérifier si le timer est terminé
final isTimerFinishedProvider = Provider.family<bool, int>((ref, duration) {
  return ref.watch(timerProvider(duration)).isFinished;
});

// Obtenir le temps restant formaté
final timerDisplayProvider = Provider.family<String, int>((ref, duration) {
  return ref.watch(timerProvider(duration)).displayTime;
});

// Obtenir le progrès (0.0 à 1.0)
final timerProgressProvider = Provider.family<double, int>((ref, duration) {
  return ref.watch(timerProvider(duration)).progress;
});
