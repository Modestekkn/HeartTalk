import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
  });

  LinearGradient get gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'description': description,
      'primary_color': primaryColor.toARGB32().toString(),
      'secondary_color': secondaryColor.toARGB32().toString(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      emoji: map['emoji'] as String,
      description: map['description'] as String,
      primaryColor: Color(int.parse(map['primary_color'])),
      secondaryColor: Color(int.parse(map['secondary_color'])),
    );
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? emoji,
    String? description,
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }
}
