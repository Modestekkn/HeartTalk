class QuestionModel {
  final String id;
  final String categoryId;
  final String text;
  final int level; // 1=Léger, 2=Moyen, 3=Profond
  final bool isUsed; // Marquée comme déjà utilisée dans la session

  const QuestionModel({
    required this.id,
    required this.categoryId,
    required this.text,
    this.level = 1,
    this.isUsed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'text': text,
      'level': level,
      'is_used': isUsed ? 1 : 0,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as String,
      categoryId: map['category_id'] as String,
      text: map['text'] as String,
      level: map['level'] as int? ?? 1,
      isUsed: (map['is_used'] as int? ?? 0) == 1,
    );
  }

  QuestionModel copyWith({
    String? id,
    String? categoryId,
    String? text,
    int? level,
    bool? isUsed,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      text: text ?? this.text,
      level: level ?? this.level,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}
