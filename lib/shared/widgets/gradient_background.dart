import 'package:flutter/material.dart';

/// Widget qui affiche un fond dégradé selon la catégorie ou un gradient personnalisé
class GradientBackground extends StatelessWidget {
  final LinearGradient gradient;
  final Widget child;

  const GradientBackground({
    super.key,
    required this.gradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: child,
    );
  }
}
