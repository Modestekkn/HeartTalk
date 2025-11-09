import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Column(
            children: [
              // Section Question (moitié supérieure)
              Expanded(
                child: _AnimatedSelectionCard(
                  onTap: () => _selectQuestion(context),
                  gradient: _getQuestionGradient(category.name),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        size: 80,
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                      const SizedBox(height: AppStyles.space3),
                      const Text(
                        'Question',
                        style: TextStyle(
                          fontSize: 56,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bandeau joueur
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.space4,
                  vertical: AppStyles.space3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                ),
                child: Text(
                  currentPlayer.name,
                  style: AppStyles.h2(
                    color: AppColors.white,
                    fontweight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Section Sujet de discussion (moitié inférieure)
              Expanded(
                child: _AnimatedSelectionCard(
                  onTap: () => _selectTopic(context),
                  gradient: _getTopicGradient(category.name),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 80,
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                      const SizedBox(height: AppStyles.space3),
                      const Text(
                        'Sujet de\ndiscussion',
                        style: TextStyle(
                          fontSize: 48,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient _getQuestionGradient(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'en couple':
        return AppColors.coupleAskGradient;
      case 'en amoureux':
        return AppColors.lorversAskGradient;
      case 'entre ami(e)s':
        return AppColors.friendsAskGradient;
      default:
        return AppColors.coupleAskGradient;
    }
  }

  LinearGradient _getTopicGradient(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'en couple':
        return AppColors.coupleTopicGradient;
      case 'en amoureux':
        return AppColors.lorversTopicGradient;
      case 'entre ami(e)s':
        return AppColors.friendsTopicGradient;
      default:
        return AppColors.coupleTopicGradient;
    }
  }
}

// Widget animé pour les cartes de sélection
class _AnimatedSelectionCard extends StatefulWidget {
  final VoidCallback onTap;
  final LinearGradient gradient;
  final Widget child;

  const _AnimatedSelectionCard({
    required this.onTap,
    required this.gradient,
    required this.child,
  });

  @override
  State<_AnimatedSelectionCard> createState() => _AnimatedSelectionCardState();
}

class _AnimatedSelectionCardState extends State<_AnimatedSelectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                boxShadow: _isPressed
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
              ),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
