import 'package:flutter/material.dart';
import 'package:heartalk/core/constants/app_colors.dart';
import 'package:heartalk/core/constants/app_styles.dart';
import 'package:heartalk/features/category/presentation/widgets/category_card.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choisissez votre mode",
              textAlign: TextAlign.center,
              style: AppStyles.h4(),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.coupleSecondary,
        elevation: 0,
      ),
      backgroundColor: AppColors.bgCategory,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CategoryCard(),
              CategoryCard(),
              CategoryCard()
            ],
          ),
        ),
      ),
    );
  }
}
