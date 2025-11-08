import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 274,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.orange
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("a")
            ],
          )
        ],
      ),
    );
  }
}
