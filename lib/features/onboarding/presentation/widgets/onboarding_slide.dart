import 'package:flutter/material.dart';
import 'package:heartalk/core/constants/app_styles.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.pathImage,
    required this.title,
    required this.subTitle,
  });

  final String pathImage;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 25,
        children: [
          Image.asset(pathImage),
          Text(title, style: AppStyles.h2(), textAlign: TextAlign.center),
          Text(
            subTitle,
            style: AppStyles.bodyLarge(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}
