import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/widgets.dart';
import '../../category/providers/category_provider.dart';
import '../providers/players_provider.dart';

class PlayersListScreen extends ConsumerWidget {
  const PlayersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            category.name,
            style: AppStyles.h3(color: AppColors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.white),
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
                const SizedBox(height: AppStyles.space3),

                // Bouton Ajouter un joueur
                CustomButton(
                  text: 'Ajouter un joueur',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  type: ButtonType.secondary,
                  icon: Icons.add,
                ),

                const SizedBox(height: AppStyles.space4),

                // Liste des joueurs
                Expanded(
                  child: players.isEmpty
                      ? Center(
                          child: Text(
                            'Aucun joueur ajouté',
                            style: AppStyles.body(color: AppColors.white),
                          ),
                        )
                      : ListView.separated(
                          itemCount: players.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppStyles.space3),
                          itemBuilder: (context, index) {
                            final player = players[index];
                            return _PlayerCard(
                              player: player,
                              category: category,
                              onDelete: () {
                                ref
                                    .read(playersProvider.notifier)
                                    .removePlayer(player.id);
                              },
                            );
                          },
                        ),
                ),

                const SizedBox(height: AppStyles.space4),

                // Bouton Lancer le jeu
                if (players.length >= 2)
                  CustomButton(
                    text: 'Lancer le jeu',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.spinWheel);
                    },
                    gradient: category.gradient,
                    icon: Icons.play_arrow_rounded,
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(AppStyles.space3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: AppStyles.borderLg,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: AppStyles.space2),
                        Expanded(
                          child: Text(
                            'Vous les champs sont requis. En complétant la notre du joueur obtenez de meilleures expériences de jeu',
                            style: AppStyles.bodySmall(color: AppColors.white),
                          ),
                        ),
                      ],
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

class _PlayerCard extends StatelessWidget {
  final dynamic player;
  final dynamic category;
  final VoidCallback onDelete;

  const _PlayerCard({
    required this.player,
    required this.category,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.space3,
        vertical: AppStyles.space3,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [category.primaryColor, category.secondaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: AppStyles.borderLg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône du genre
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                player.genderEmoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: AppStyles.space3),
          // Nom du joueur
          Expanded(
            child: Text(
              player.name,
              style: AppStyles.body(
                color: AppColors.white,
                fontweight: FontWeight.w600,
              ),
            ),
          ),
          // Bouton supprimer
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.white),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
