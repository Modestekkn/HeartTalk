import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../providers/game_provider.dart';

class GameSelectionScreen extends ConsumerStatefulWidget {
  const GameSelectionScreen({super.key});

  @override
  ConsumerState<GameSelectionScreen> createState() =>
      _GameSelectionScreenState();
}

class _GameSelectionScreenState extends ConsumerState<GameSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Initialiser le jeu si pas déjà fait
    Future.microtask(() {
      final gameState = ref.read(gameProvider);
      if (gameState.sessionId?.isEmpty ?? true) {
        ref.read(gameProvider.notifier).startGame();
      }
    });
  }

  Future<void> _selectQuestion(BuildContext context) async {
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.loadQuestion();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.questionDisplay);
    }
  }

  Future<void> _selectTopic(BuildContext context) async {
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.loadTopic();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.topicTimer);
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(selectedCategoryProvider);
    final gameState = ref.watch(gameProvider);
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
                const SizedBox(height: AppStyles.space5),

                // Avatar et nom du joueur actif
                PlayerAvatar(player: currentPlayer, size: 100, showName: true),

                const SizedBox(height: AppStyles.space3),

                Text(
                  "C'est à toi de choisir !",
                  style: AppStyles.h2(
                    color: AppColors.textLight,
                    fontweight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.space2),

                Text(
                  'Question ou Thème ?',
                  style: AppStyles.body(
                    color: AppColors.textLight.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.space6),

                // Carte Question
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectQuestion(context),
                    child: CustomCard(
                      padding: const EdgeInsets.all(AppStyles.space5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: category.gradient,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.question_mark_rounded,
                              size: 40,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: AppStyles.space3),
                          Text(
                            'Question',
                            style: AppStyles.h2(
                              color: AppColors.textPrimary,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppStyles.space2),
                          Text(
                            'Pose une question au groupe',
                            style: AppStyles.body(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space4),

                // Carte Thème
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTopic(context),
                    child: CustomCard(
                      padding: const EdgeInsets.all(AppStyles.space5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.neutreSecondary,
                                  AppColors.neutreSecondary.withValues(
                                    alpha: 0.7,
                                  ),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 40,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: AppStyles.space3),
                          Text(
                            'Thème',
                            style: AppStyles.h2(
                              color: AppColors.textPrimary,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppStyles.space2),
                          Text(
                            'Lance une discussion chronométrée',
                            style: AppStyles.body(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
