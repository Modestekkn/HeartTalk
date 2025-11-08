class TopicModel {
  final String id;
  final String categoryId;
  final String text;
  final int duration; // Durée en secondes (par défaut 300 = 5 min)
  final int level; // 1=Léger, 2=Moyen, 3=Profond
  final bool isUsed;

  const TopicModel({
    required this.id,
    required this.categoryId,
    required this.text,
    this.duration = 300,
    this.level = 1,
    this.isUsed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'text': text,
      'duration': duration,
      'level': level,
      'is_used': isUsed ? 1 : 0,
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      id: map['id'] as String,
      categoryId: map['category_id'] as String,
      text: map['text'] as String,
      duration: map['duration'] as int? ?? 300,
      level: map['level'] as int? ?? 1,
      isUsed: (map['is_used'] as int? ?? 0) == 1,
    );
  }

  TopicModel copyWith({
    String? id,
    String? categoryId,
    String? text,
    int? duration,
    int? level,
    bool? isUsed,
  }) {
    return TopicModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      text: text ?? this.text,
      duration: duration ?? this.duration,
      level: level ?? this.level,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}
