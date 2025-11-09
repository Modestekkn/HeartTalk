import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../../players/providers/players_provider.dart';

class SpinWheelScreen extends ConsumerStatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  ConsumerState<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends ConsumerState<SpinWheelScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  bool _isSpinning = false;
  int _selectedPlayerIndex = 0;

  @override
  void initState() {
    super.initState();

    // Animation de rotation avec effet de ralentissement
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(
          begin: 0,
          end: 10 * pi * 2, // 10 tours complets
        ).animate(
          CurvedAnimation(
            parent: _rotationController,
            curve: Curves.easeOutCubic, // Ralentissement progressif
          ),
        );

    // Animation de scale pour effet de pression
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _spinWheel() async {
    if (_isSpinning) return;

    setState(() => _isSpinning = true);

    final players = ref.read(playersProvider);
    if (players.isEmpty) return;

    // Vibration au démarrage
    HapticFeedback.mediumImpact();

    // Effet de pression
    await _scaleController.forward();
    await _scaleController.reverse();

    // Choisir le joueur final avant l'animation
    final finalIndex = Random().nextInt(players.length);

    // Animation de rotation
    _rotationController.reset();
    await _rotationController.forward();

    if (mounted) {
      // Vibration à la fin
      HapticFeedback.heavyImpact();

      setState(() {
        _selectedPlayerIndex = finalIndex;
        _isSpinning = false;
      });

      // Définir le joueur actuel
      ref.read(currentPlayerProvider.notifier).state = players[finalIndex];

      // Attendre avant de naviguer
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        Navigator.pushNamed(context, AppRouter.gameSelection);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(selectedCategoryProvider);
    final players = ref.watch(playersProvider);

    if (category == null || players.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'Erreur: Aucune catégorie ou joueur',
            style: AppStyles.body(),
          ),
        ),
      );
    }

    final selectedPlayer = players[_selectedPlayerIndex];

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
          child: Stack(
            children: [
              // Image de fond avec overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/illustrations/onboarding_3.png',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        category.primaryColor.withValues(alpha: 0.7),
                        BlendMode.multiply,
                      ),
                    ),
                  ),
                ),
              ),

              // Contenu principal centré
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar du joueur sélectionné avec animation
                    AnimatedScale(
                      scale: _isSpinning ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            selectedPlayer.genderEmoji,
                            style: const TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.space4),

                    // Nom du joueur
                    AnimatedOpacity(
                      opacity: _isSpinning ? 0.5 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        selectedPlayer.name,
                        style: AppStyles.h2(
                          color: AppColors.white,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.space5),

                    // Bouton Lancer la roue avec animation (taille réduite)
                    GestureDetector(
                      onTap: _spinWheel,
                      child: AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 30,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Cercles décoratifs tournants
                                    ...List.generate(players.length, (index) {
                                      final angle =
                                          (2 * pi / players.length) * index;
                                      return Transform.translate(
                                        offset: Offset(
                                          cos(angle) * 56,
                                          sin(angle) * 56,
                                        ),
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index == _selectedPlayerIndex
                                                ? category.primaryColor
                                                : category.primaryColor
                                                      .withValues(alpha: 0.3),
                                          ),
                                        ),
                                      );
                                    }),

                                    // Icône centrale
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        size: 48,
                                        color: category.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.space4),

                    // Texte
                    Text(
                      _isSpinning ? 'Sélection...' : 'Lancer la roue !',
                      style: AppStyles.h3(
                        color: AppColors.white,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
