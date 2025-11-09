import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../providers/game_provider.dart';

class QuestionDisplayScreen extends ConsumerStatefulWidget {
  const QuestionDisplayScreen({super.key});

  @override
  ConsumerState<QuestionDisplayScreen> createState() =>
      _QuestionDisplayScreenState();
}

class _QuestionDisplayScreenState extends ConsumerState<QuestionDisplayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _nextQuestion(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.nextQuestion();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.spinWheel);
    }
  }

  Future<void> _skipTurn(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();
    final gameNotifier = ref.read(gameProvider.notifier);
    await gameNotifier.skipTurn();

    if (context.mounted) {
      Navigator.pushNamed(context, AppRouter.spinWheel);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textLight),
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.settings);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppStyles.space4),
            child: Column(
              children: [
                const Spacer(),

                // Titre "Question" avec animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Question',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space2),

                // Barre de soulignement
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const Spacer(),

                // Carte de la question avec animation
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
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
                            currentQuestion.text,
                            style: AppStyles.h3(
                              color: AppColors.textPrimary,
                              fontweight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppStyles.space3),
                          // Étoiles de difficulté
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Icon(
                                  index < currentQuestion.level
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  color: index < currentQuestion.level
                                      ? AppColors.warning
                                      : AppColors.textSecondary,
                                  size: 28,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Boutons de contrôle
                Row(
                  children: [
                    // Bouton Passer
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _skipTurn(context, ref),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppStyles.space3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: AppColors.white,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Passer',
                          style: AppStyles.body(
                            color: AppColors.white,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppStyles.space3),
                    // Bouton Suivant
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _nextQuestion(context, ref),
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
                          'Suivant',
                          style: AppStyles.body(
                            color: AppColors.textPrimary,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
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
