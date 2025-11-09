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
          child: Column(
            children: [
              // Bandeau joueur
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.space4,
                  vertical: AppStyles.space3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Joueur A',
                      style: AppStyles.h3(
                        color: AppColors.white,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Section Question (moitié supérieure)
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectQuestion(context),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          category.primaryColor.withValues(alpha: 0.9),
                          category.secondaryColor.withValues(alpha: 0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Question',
                        style: AppStyles.display(
                          color: AppColors.white,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Section Sujet de discussion (moitié inférieure)
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTopic(context),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          category.secondaryColor,
                          category.primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sujet de\ndiscussion',
                        style: AppStyles.display(
                          color: AppColors.white,
                          fontweight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
