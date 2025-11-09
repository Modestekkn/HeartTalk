import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../features/players/data/models/player_model.dart';

/// Toggle pour sélectionner le genre (Homme/Femme)
class GenderToggle extends StatefulWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender> onGenderSelected;

  const GenderToggle({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  State<GenderToggle> createState() => _GenderToggleState();
}

class _GenderToggleState extends State<GenderToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGenderTap(Gender gender) {
    HapticFeedback.mediumImpact();
    _controller.forward().then((_) => _controller.reverse());
    widget.onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderOption(
            icon: Icons.male,
            label: 'Homme',
            isSelected: widget.selectedGender == Gender.homme,
            onTap: () => _onGenderTap(Gender.homme),
            color: const Color(0xFF3498DB),
          ),
        ),
        const SizedBox(width: AppStyles.space3),
        Expanded(
          child: _GenderOption(
            icon: Icons.female,
            label: 'Femme',
            isSelected: widget.selectedGender == Gender.femme,
            onTap: () => _onGenderTap(Gender.femme),
            color: const Color(0xFFE91E63),
          ),
        ),
      ],
    );
  }
}

class _GenderOption extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _GenderOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  State<_GenderOption> createState() => _GenderOptionState();
}

class _GenderOptionState extends State<_GenderOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
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

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.space2,
            vertical: AppStyles.space3,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected ? widget.color : AppColors.grey100,
            borderRadius: AppStyles.borderLg,
            border: Border.all(
              color: widget.isSelected ? widget.color : AppColors.grey300,
              width: widget.isSelected ? 2 : 1.5,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: widget.isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceOut,
                child: Icon(
                  widget.icon,
                  size: 32,
                  color: widget.isSelected
                      ? AppColors.white
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppStyles.space1),
              Text(
                widget.label,
                style: AppStyles.bodySmall(
                  color: widget.isSelected
                      ? AppColors.white
                      : AppColors.textPrimary,
                  fontweight: widget.isSelected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
