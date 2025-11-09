import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

enum ButtonType { primary, secondary, outline }

/// Bouton personnalisé avec différents styles et animations
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final LinearGradient? gradient;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.gradient,
    this.icon,
    this.width,
    this.height,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
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
    if (!widget.isDisabled && !widget.isLoading) {
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (!widget.isDisabled && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isDisabled || widget.isLoading;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: isDisabled ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled ? 0.5 : 1.0,
          child: Container(
            width: widget.width,
            height: widget.height ?? 56,
            decoration: _getDecoration(),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.type) {
      case ButtonType.primary:
        return BoxDecoration(
          gradient: widget.gradient ?? AppColors.neutreGradient,
          borderRadius: AppStyles.borderLg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );

      case ButtonType.secondary:
        return BoxDecoration(
          color: AppColors.grey100,
          borderRadius: AppStyles.borderLg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );

      case ButtonType.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: AppStyles.borderLg,
          border: Border.all(color: AppColors.textLight, width: 2),
        );
    }
  }

  Widget _buildContent() {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.type == ButtonType.primary
                        ? AppColors.textLight
                        : AppColors.textPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: _getTextColor(), size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: AppStyles.h4(
                      color: _getTextColor(),
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color _getTextColor() {
    switch (widget.type) {
      case ButtonType.primary:
        return AppColors.textLight;
      case ButtonType.secondary:
        return AppColors.textPrimary;
      case ButtonType.outline:
        return AppColors.textLight;
    }
  }
}
