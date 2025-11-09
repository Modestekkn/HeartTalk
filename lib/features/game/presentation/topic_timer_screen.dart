import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/game_provider.dart';

class TopicTimerScreen extends ConsumerStatefulWidget {
  const TopicTimerScreen({super.key});

  @override
  ConsumerState<TopicTimerScreen> createState() => _TopicTimerScreenState();
}

class _TopicTimerScreenState extends ConsumerState<TopicTimerScreen> {
  Timer? _timer;
  late int _remainingSeconds;
  late int _totalSeconds;
  bool _isPaused = false;
  bool _hasVibrated = false;

  @override
  void initState() {
    super.initState();
    // Récupérer la durée depuis les paramètres
    final settings = ref.read(settingsProvider);
    _remainingSeconds = settings.defaultTopicDuration;
    _totalSeconds = settings.defaultTopicDuration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;

          // Vibration à 10 secondes
          if (_remainingSeconds == 10 && !_hasVibrated) {
            HapticFeedback.heavyImpact();
            _hasVibrated = true;
          }

          // Fin du timer
          if (_remainingSeconds == 0) {
            _endTopic();
          }
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  Future<void> _endTopic() async {
    _timer?.cancel();
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.nextTopic();

    if (mounted) {
      Navigator.pushNamed(context, AppRouter.gameSelection);
    }
  }

  Future<void> _skipTopic() async {
    _timer?.cancel();
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.skipTurn();

    if (mounted) {
      Navigator.pushNamed(context, AppRouter.gameSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(selectedCategoryProvider);
    final gameState = ref.watch(gameProvider);
    final currentTopic = gameState.currentTopic;
    final currentPlayer = gameState.currentPlayer;

    if (category == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Erreur: Aucune catégorie sélectionnée',
            style: AppStyles.body(),
          ),
        ),
      );
    }

    if (currentTopic == null) {
      return Scaffold(
        body: Center(
          child: Text('Erreur: Aucun thème chargé', style: AppStyles.body()),
        ),
      );
    }

    if (currentPlayer == null) {
      return Scaffold(
        body: Center(
          child: Text('Erreur: Aucun joueur actif', style: AppStyles.body()),
        ),
      );
    }

    return GradientBackground(
      gradient: category.gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            category.name,
            style: AppStyles.h3(
              color: AppColors.textLight,
              fontweight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppStyles.space4),
            child: Column(
              children: [
                const SizedBox(height: AppStyles.space4),

                // Avatar du joueur actif
                PlayerAvatar(player: currentPlayer, size: 80, showName: true),

                const SizedBox(height: AppStyles.space5),

                // Badge "Thème"
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.space3,
                    vertical: AppStyles.space1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppStyles.radiusFull),
                  ),
                  child: Text(
                    'THÈME',
                    style: AppStyles.bodySmall(
                      color: AppColors.textLight,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space5),

                // Timer circulaire
                CircularTimer(
                  remainingSeconds: _remainingSeconds,
                  totalSeconds: _totalSeconds,
                  size: 200,
                ),

                const SizedBox(height: AppStyles.space5),

                // Carte du thème
                Expanded(
                  child: CustomCard(
                    padding: const EdgeInsets.all(AppStyles.space5),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          currentTopic.text,
                          style: AppStyles.h2(
                            color: AppColors.textPrimary,
                            fontweight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space5),

                // Boutons de contrôle
                Row(
                  children: [
                    // Bouton Pause/Reprendre
                    Expanded(
                      child: CustomButton(
                        text: _isPaused ? 'Reprendre' : 'Pause',
                        type: ButtonType.outline,
                        onPressed: _togglePause,
                        icon: _isPaused ? Icons.play_arrow : Icons.pause,
                      ),
                    ),
                    const SizedBox(width: AppStyles.space3),
                    // Bouton Terminer
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: 'Terminer',
                        gradient: category.gradient,
                        onPressed: _endTopic,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppStyles.space3),

                // Lien Passer le tour
                TextButton(
                  onPressed: _skipTopic,
                  child: Text(
                    'Passer le tour',
                    style: AppStyles.body(
                      color: AppColors.textLight,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
