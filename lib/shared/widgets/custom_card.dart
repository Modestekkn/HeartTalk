import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

/// Carte personnalisée avec effet glassmorphism
class CustomCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final LinearGradient? gradient;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool enableHover;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.gradient,
    this.width,
    this.height,
    this.padding,
    this.enableHover = true,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isHovering = true);
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() => _isHovering = false);
        }
      });
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
      setState(() => _isHovering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: widget.enableHover && _isHovering ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: widget.padding ?? const EdgeInsets.all(AppStyles.space4),
            decoration: BoxDecoration(
              gradient: widget.gradient,
              color: widget.gradient == null ? AppColors.glassMorphism : null,
              borderRadius: AppStyles.borderXl,
              border: Border.all(color: AppColors.glassBorder, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: _isHovering ? 20 : 15,
                  offset: Offset(0, _isHovering ? 8 : 4),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
