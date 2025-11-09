import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/tts_service.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/game_provider.dart';

class TopicTimerScreen extends ConsumerStatefulWidget {
  const TopicTimerScreen({super.key});

  @override
  ConsumerState<TopicTimerScreen> createState() => _TopicTimerScreenState();
}

class _TopicTimerScreenState extends ConsumerState<TopicTimerScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _remainingSeconds;
  late int _totalSeconds;
  bool _isPaused = false;
  bool _hasVibrated = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final TtsService _ttsService = TtsService();
  int _autoReadCount = 0; // Compteur de lectures automatiques

  @override
  void initState() {
    super.initState();

    // Animation de pulsation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Récupérer la durée depuis les paramètres
    final settings = ref.read(settingsProvider);
    _remainingSeconds = settings.defaultTopicDuration;
    _totalSeconds = settings.defaultTopicDuration;
    _startTimer();
    _ttsService.initialize();

    // Lecture automatique après un délai
    _scheduleAutoRead();
  }

  void _scheduleAutoRead() async {
    // Attendre que le sujet soit chargé
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      final gameState = ref.read(gameProvider);
      final topic = gameState.currentTopic;
      if (topic != null && _autoReadCount < 2) {
        await _autoRead(topic.text);
      }
    }
  }

  Future<void> _autoRead(String text) async {
    if (_autoReadCount >= 2) return;

    await _ttsService.speak(text);

    // Attendre la fin de la lecture (estimation basée sur la longueur du texte)
    final estimatedDuration = Duration(seconds: (text.length ~/ 15) + 2);
    await Future.delayed(estimatedDuration);

    if (mounted) {
      _autoReadCount++;

      // Si première lecture, programmer la deuxième après un délai
      if (_autoReadCount == 1) {
        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) {
          await _autoRead(text);
        }
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _ttsService.stop();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;

          // Démarrer l'animation de pulsation quand < 30s
          if (_remainingSeconds <= 30 && _remainingSeconds > 0) {
            if (!_pulseController.isAnimating) {
              _pulseController.repeat(reverse: true);
            }
          }

          // Vibration à 10 secondes
          if (_remainingSeconds == 10 && !_hasVibrated) {
            HapticFeedback.heavyImpact();
            _hasVibrated = true;
          }

          // Fin du timer avec effet dramatique
          if (_remainingSeconds == 0) {
            HapticFeedback.heavyImpact();
            _pulseController.stop();
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
      Navigator.pushNamed(context, AppRouter.spinWheel);
    }
  }

  Future<void> _skipTopic() async {
    _timer?.cancel();
    _pulseController.stop();
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.skipTurn();

    if (mounted) {
      Navigator.pushNamed(context, AppRouter.spinWheel);
    }
  }

  Color _getTimerColor() {
    if (_remainingSeconds <= 10) {
      return const Color(0xFFFF4444); // Rouge urgent
    } else if (_remainingSeconds <= 30) {
      return const Color(0xFFFFAA00); // Orange attention
    } else {
      return const Color(0xFF00FF9D); // Vert normal
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.textLight,
                size: 32,
                weight: 200,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.settings);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.space4,
              vertical: AppStyles.space3,
            ),
            child: Column(
              children: [
                Text(
                  currentPlayer.name,
                  style: AppStyles.h2(
                    color: AppColors.white,
                    fontweight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppStyles.space4),

                // Badge "SUJET DE DISCUSSION"
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.space4,
                    vertical: AppStyles.space2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'SUJET DE DISCUSSION',
                    style: AppStyles.body(
                      color: AppColors.white,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                // Timer circulaire avec animation de pulsation (taille réduite)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final isUrgent = _remainingSeconds <= 30;
                    return Transform.scale(
                      scale: isUrgent ? _pulseAnimation.value : 1.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(
                              value: _remainingSeconds / _totalSeconds,
                              strokeWidth: 10,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.3,
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getTimerColor(),
                              ),
                            ),
                          ),
                          Text(
                            '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: _getTimerColor(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Spacer(),

                // Thème
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppStyles.space5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        currentTopic.text,
                        style: AppStyles.h3(
                          color: AppColors.textPrimary,
                          fontweight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Boutons de contrôle
                Row(
                  children: [
                    // Bouton Pause
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _togglePause,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppStyles.space3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: AppColors.textPrimary,
                        ),
                        label: Text(
                          _isPaused ? 'Reprendre' : 'Pause',
                          style: AppStyles.body(
                            color: AppColors.textPrimary,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppStyles.space3),
                    // Bouton Terminer
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _endTopic,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppStyles.space3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Terminer',
                          style: AppStyles.body(
                            color: AppColors.textPrimary,
                            fontweight: FontWeight.w600,
                          ),
                        ),
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
                      color: AppColors.white,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
