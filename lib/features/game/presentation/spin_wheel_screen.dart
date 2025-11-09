import 'dart:math';
import 'package:flutter/material.dart';
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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSpinning = false;
  int _selectedPlayerIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_isSpinning) return;

    setState(() => _isSpinning = true);

    final players = ref.read(playersProvider);
    if (players.isEmpty) return;

    // Animation de sélection rapide
    int spins = 0;
    const totalSpins = 20;

    _controller.reset();
    _controller.forward();

    // Changer rapidement entre les joueurs
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _selectedPlayerIndex = Random().nextInt(players.length);
          spins++;
        });
      }
      return spins < totalSpins && mounted;
    }).then((_) {
      if (mounted) {
        // Sélection finale aléatoire
        final finalIndex = Random().nextInt(players.length);
        setState(() {
          _selectedPlayerIndex = finalIndex;
          _isSpinning = false;
        });

        // Définir le joueur actuel
        ref.read(currentPlayerProvider.notifier).state = players[finalIndex];

        // Attendre un peu puis naviguer
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushNamed(context, AppRouter.gameSelection);
          }
        });
      }
    });
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
        body: SafeArea(
          child: Stack(
            children: [
              // Image de fond avec overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                       'assets/images/illustrations/onboarding_2.png'
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

              // Contenu principal
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),

                    // Avatar du joueur sélectionné avec animation
                    AnimatedScale(
                      scale: _isSpinning ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 120,
                        height: 120,
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
                            style: const TextStyle(fontSize: 60),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.space5),

                    // Nom du joueur
                    AnimatedOpacity(
                      opacity: _isSpinning ? 0.5 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        selectedPlayer.name,
                        style: AppStyles.h1(
                          color: AppColors.white,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Bouton Lancer la roue
                    Padding(
                      padding: const EdgeInsets.all(AppStyles.space5),
                      child: GestureDetector(
                        onTap: _spinWheel,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Cercle de progression
                              if (_isSpinning)
                                SizedBox(
                                  width: 180,
                                  height: 180,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      category.primaryColor,
                                    ),
                                  ),
                                ),

                              // Icône flèche
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 80,
                                color: category.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.space3),

                    // Texte
                    Text(
                      _isSpinning ? 'Sélection...' : 'Lancer la roue !',
                      style: AppStyles.h2(
                        color: AppColors.white,
                        fontweight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: AppStyles.space5),
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
