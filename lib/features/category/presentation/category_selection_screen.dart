import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/router/app_router.dart';
import '../providers/category_provider.dart';
import 'widgets/category_card.dart';

class CategorySelectionScreen extends ConsumerWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B5CF6), // Violet
              Color(0xFFEC4899), // Rose
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personnalisée
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.space3,
                  vertical: AppStyles.space2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge "Category" en haut à gauche
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyles.space3,
                        vertical: AppStyles.space1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(
                          AppStyles.radiusFull,
                        ),
                      ),
                      child: Text(
                        'Category',
                        style: AppStyles.bodySmall(
                          color: AppColors.textLight,
                          fontweight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Icône paramètres
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: AppColors.textLight,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.settings);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.space4),

              // Titre
              Text(
                'Choisissez votre mode',
                style: AppStyles.h2(
                  color: AppColors.textLight,
                  fontweight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppStyles.space4),

              // Liste des catégories
              Expanded(
                child: categoriesAsync.when(
                  data: (categories) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyles.space4,
                      ),
                      child: ListView.separated(
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppStyles.space4),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryCard(
                            category: category,
                            onTap: () {
                              // Sélectionner la catégorie
                              ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state =
                                  category;
                              // Naviguer vers la saisie des joueurs
                              Navigator.pushNamed(
                                context,
                                AppRouter.playerInput,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.textLight,
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                          color: AppColors.textLight.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: AppStyles.space3),
                        Text(
                          'Erreur de chargement',
                          style: AppStyles.h4(color: AppColors.textLight),
                        ),
                        const SizedBox(height: AppStyles.space2),
                        Text(
                          error.toString(),
                          style: AppStyles.bodySmall(
                            color: AppColors.textLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
