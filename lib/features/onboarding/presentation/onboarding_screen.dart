import 'package:flutter/material.dart';
import 'package:heartalk/core/constants/app_colors.dart';
import 'package:heartalk/core/constants/app_styles.dart';
import 'package:heartalk/core/router/app_router.dart';
import 'package:heartalk/features/onboarding/presentation/widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  Widget textOrIcon() {
    return _currentIndex == 3
        ? Text("Prêt", style: AppStyles.body(fontweight: FontWeight.w600))
        : Icon(
            Icons.chevron_right,
            color: AppColors.textLight,
            size: 32,
            weight: 200,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.neutreGradient),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.chevron_left,
              color: AppColors.textLight,
              size: 32,
              weight: 200,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.category);
              },
              child: Text("Passer", style: AppStyles.bodyLarge()),
            ),
          ],
        ),
        body: Center(
          child: Stack(
            alignment: AlignmentGeometry.bottomCenter,
            children: [
              PageView(
                controller: PageController(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  OnboardingSlide(
                    pathImage: "assets/images/illustrations/onboarding_1.png",
                    title: "Bienvenue sur HeartTalk !",
                    subTitle:
                        "Créez des moments uniques d’échange et de connexion avec proches.",
                  ),
                  OnboardingSlide(
                    pathImage: "assets/images/illustrations/onboarding_2.png",
                    title: "Questions & Discussions",
                    subTitle:
                        "Répondez à des questions ou lancez des discussions chronométrées pour vous découvrir vraiment.",
                  ),
                  OnboardingSlide(
                    pathImage: "assets/images/illustrations/onboarding_3.png",
                    title: "Choisissez votre mode",
                    subTitle:
                        "Chaque mode propose des questions adaptées à votre relation.",
                  ),
                  OnboardingSlide(
                    pathImage: "assets/images/illustrations/onboarding_4.png",
                    title: "C'est parti !",
                    subTitle:
                        "Prêt à créer des souvenirs inoubliables ? Lancez votre première partie maintenant !",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 3,
                      children: List.generate(
                        4,
                        (index) => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          alignment: AlignmentGeometry.bottomCenter,
                          curve: Curves.linear,
                          padding: EdgeInsets.only(right: 5),
                          width: _currentIndex == index ? 20 : 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? AppColors.textLight
                                : AppColors.amisPrimary,
                            borderRadius: BorderRadius.circular(20),
                            border: BoxBorder.all(
                              color: AppColors.textLight,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentGeometry.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _currentIndex == 3
                              ? Navigator.pushNamed(context, AppRouter.category)
                              : null;
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: AppStyles.glassDecoration(
                            gradient: AppColors.neutreGradient,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textOrIcon(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
