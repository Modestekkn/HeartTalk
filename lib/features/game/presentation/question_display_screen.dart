import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../providers/game_provider.dart';

class QuestionDisplayScreen extends ConsumerWidget {
  const QuestionDisplayScreen({super.key});

  Future<void> _nextQuestion(BuildContext context, WidgetRef ref) async {
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.nextQuestion();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.gameSelection);
    }
  }

  Future<void> _skipTurn(BuildContext context, WidgetRef ref) async {
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.skipTurn();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.gameSelection);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    final gameState = ref.watch(gameProvider);
    final currentQuestion = gameState.currentQuestion;
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

    if (currentQuestion == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Erreur: Aucune question chargée',
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
                const SizedBox(height: AppStyles.space4),

                // Avatar du joueur actif
                PlayerAvatar(player: currentPlayer, size: 80, showName: true),

                const SizedBox(height: AppStyles.space5),

                // Badge "Question"
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
                    'QUESTION',
                    style: AppStyles.bodySmall(
                      color: AppColors.textLight,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space5),

                // Carte de la question
                Expanded(
                  child: CustomCard(
                    padding: const EdgeInsets.all(AppStyles.space5),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion.text,
                              style: AppStyles.h2(
                                color: AppColors.textPrimary,
                                fontweight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppStyles.space4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => Icon(
                                  index < currentQuestion.level
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: AppColors.warning,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space5),

                // Bouton Question suivante
                CustomButton(
                  text: 'Question suivante',
                  gradient: category.gradient,
                  onPressed: () => _nextQuestion(context, ref),
                  width: double.infinity,
                ),

                const SizedBox(height: AppStyles.space3),

                // Lien Passer le tour
                TextButton(
                  onPressed: () => _skipTurn(context, ref),
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
