import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return GradientBackground(
      gradient: AppColors.neutreGradient,
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
            'Paramètre',
            style: AppStyles.h3(
              color: AppColors.textLight,
              fontweight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textLight),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppStyles.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Badges rapides en haut
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _QuickBadge(
                      icon: Icons.star_outline,
                      label: 'Niveau',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fonctionnalité bientôt disponible'),
                          ),
                        );
                      },
                    ),
                    _QuickBadge(
                      icon: Icons.favorite_outline,
                      label: 'Défi',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fonctionnalité bientôt disponible'),
                          ),
                        );
                      },
                    ),
                    _QuickBadge(
                      icon: Icons.people_outline,
                      label: 'Modifier les\njoueurs',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fonctionnalité bientôt disponible'),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: AppStyles.space5),

                // Liste des options
                _SettingItem(
                  icon: Icons.language,
                  title: 'Langues',
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.textLight,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Sélection de langue - Bientôt disponible',
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppStyles.space2),

                _SettingItem(
                  icon: Icons.music_note,
                  title: 'Musique',
                  trailing: Switch(
                    value: settings.soundEnabled,
                    onChanged: (_) =>
                        ref.read(settingsProvider.notifier).toggleSound(),
                    activeTrackColor: AppColors.textLight.withValues(
                      alpha: 0.3,
                    ),
                    thumbColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.textLight;
                      }
                      return AppColors.textLight.withValues(alpha: 0.7);
                    }),
                  ),
                ),

                const SizedBox(height: AppStyles.space2),

                _SettingItem(
                  icon: Icons.volume_up,
                  title: 'Son',
                  trailing: Switch(
                    value: settings.vibrationEnabled,
                    onChanged: (_) =>
                        ref.read(settingsProvider.notifier).toggleVibration(),
                    activeTrackColor: AppColors.textLight.withValues(
                      alpha: 0.3,
                    ),
                    thumbColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.textLight;
                      }
                      return AppColors.textLight.withValues(alpha: 0.7);
                    }),
                  ),
                ),

                const SizedBox(height: AppStyles.space2),

                _SettingItem(
                  icon: Icons.star_outline,
                  title: 'Avis',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Merci ! Évaluez-nous sur le store'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppStyles.space2),

                _SettingItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Contactez-nous',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact : support@heartalk.app'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppStyles.space2),

                _SettingItem(
                  icon: Icons.power_settings_new,
                  title: 'Quitter',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Quitter'),
                        content: const Text(
                          'Êtes-vous sûr de vouloir quitter l\'application ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              'Quitter',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppStyles.space6),

                Center(
                  child: Text(
                    'HeartTalk v1.0.0',
                    style: AppStyles.bodySmall(
                      color: AppColors.textLight.withValues(alpha: 0.6),
                    ),
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

class _QuickBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickBadge({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.textLight.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textLight, size: 32),
          ),
          const SizedBox(height: AppStyles.space2),
          Text(
            label,
            style: AppStyles.bodySmall(color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.radiusLg),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.space4,
            vertical: AppStyles.space3,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.textLight.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.textLight, size: 24),
              const SizedBox(width: AppStyles.space3),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.body(
                    color: AppColors.textLight,
                    fontweight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
