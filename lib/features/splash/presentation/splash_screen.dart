import 'package:flutter/material.dart';
import 'package:heartalk/core/constants/app_colors.dart';
import 'package:heartalk/core/constants/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(AppStyles.durationMiniShort);
    if (mounted) {
      Navigator.pushNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWelcome,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppStyles.space3,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(25.0),
              width: 289.0,
              height: 289.0,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 289.0,
                height: 289.0,
              ),
            ),
          ),
          SizedBox(height: 0),
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "By",
                style: AppStyles.h3(
                  color: AppColors.textLight,
                  fontweight: FontWeight.w400,
                ),
              ),
              Text(
                "ModeDevIT",
                style: AppStyles.h1(
                  color: AppColors.textLight,
                  fontweight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
