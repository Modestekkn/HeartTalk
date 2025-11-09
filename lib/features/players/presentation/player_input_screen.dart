import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../providers/players_provider.dart';
import '../data/models/player_model.dart';

class PlayerInputScreen extends ConsumerStatefulWidget {
  const PlayerInputScreen({super.key});

  @override
  ConsumerState<PlayerInputScreen> createState() => _PlayerInputScreenState();
}

class _PlayerInputScreenState extends ConsumerState<PlayerInputScreen> {
  final _nameController = TextEditingController();
  Gender? _selectedGender;
  String? _errorText;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateAndAddPlayer() {
    final name = _nameController.text.trim();

    // Validation
    if (name.isEmpty) {
      setState(() => _errorText = 'Veuillez entrer un nom');
      return;
    }

    if (name.length < 2) {
      setState(() => _errorText = 'Le nom doit contenir au moins 2 caractères');
      return;
    }

    if (_selectedGender == null) {
      setState(() => _errorText = 'Veuillez sélectionner un genre');
      return;
    }

    // Ajouter le joueur
    ref
        .read(playersProvider.notifier)
        .createPlayer(name: name, gender: _selectedGender!);

    // Réinitialiser le formulaire
    setState(() {
      _nameController.clear();
      _selectedGender = null;
      _errorText = null;
    });

    // Navigation vers la liste des joueurs
    Navigator.pushNamed(context, AppRouter.playersList);
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(selectedCategoryProvider);
    final players = ref.watch(playersProvider);

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
            'Ajouter un joueur',
            style: AppStyles.h3(
              color: AppColors.textLight,
              fontweight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            if (players.isNotEmpty)
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.playersList);
                },
                icon: Badge(
                  label: Text('${players.length}'),
                  child: const Icon(Icons.group, color: AppColors.textLight),
                ),
              ),
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
                const SizedBox(height: AppStyles.space5),
                // Formulaire
                Expanded(
                  child: CustomCard(
                    padding: const EdgeInsets.all(AppStyles.space4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Input nom
                        CustomInput(
                          controller: _nameController,
                          label: 'Prénom',
                          hint: 'Entrez votre prénom',
                          errorText: _errorText,
                          prefixIcon: const Icon(Icons.person_outline),
                          onChanged: (value) {
                            if (_errorText != null) {
                              setState(() => _errorText = null);
                            }
                          },
                        ),
                        const SizedBox(height: AppStyles.space3),

                        // Label Genre
                        Text(
                          'Genre',
                          style: AppStyles.body(
                            fontweight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppStyles.space2),

                        // Toggle Genre
                        GenderToggle(
                          selectedGender: _selectedGender,
                          onGenderSelected: (gender) {
                            setState(() {
                              _selectedGender = gender;
                              if (_errorText != null) {
                                _errorText = null;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.space4),

                // Bouton Valider
                CustomButton(
                  text: 'Valider',
                  gradient: category.gradient,
                  onPressed: _validateAndAddPlayer,
                  width: double.infinity,
                  icon: Icons.check_circle_outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
