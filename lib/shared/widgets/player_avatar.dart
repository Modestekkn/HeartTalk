import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../features/players/data/models/player_model.dart';

/// Avatar circulaire pour afficher un joueur
class PlayerAvatar extends StatelessWidget {
  final PlayerModel player;
  final double size;
  final bool showName;
  final bool animate;

  const PlayerAvatar({
    super.key,
    required this.player,
    this.size = 80,
    this.showName = false,
    this.animate = false,
  });

  Color _getGenderColor() {
    return player.gender == Gender.homme
        ? const Color(0xFF3498DB)
        : const Color(0xFFE91E63);
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_getGenderColor(), _getGenderColor().withValues(alpha: 0.7)],
        ),
        boxShadow: [
          BoxShadow(
            color: _getGenderColor().withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.white, width: 3),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              player.initials,
              style: TextStyle(
                color: AppColors.white,
                fontSize: size * 0.35,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: size * 0.05),
            Text(player.genderEmoji, style: TextStyle(fontSize: size * 0.25)),
          ],
        ),
      ),
    );

    if (!showName) {
      return animate ? _AnimatedAvatar(child: avatar) : avatar;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        animate ? _AnimatedAvatar(child: avatar) : avatar,
        const SizedBox(height: AppStyles.space2),
        Text(
          player.name,
          style: AppStyles.h4(
            color: AppColors.textLight,
            fontweight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _AnimatedAvatar extends StatefulWidget {
  final Widget child;

  const _AnimatedAvatar({required this.child});

  @override
  State<_AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<_AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _rotationAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
