
enum Gender { homme, femme }

enum Preference { hommes, femmes, both }

class PlayerModel {
  final String id;
  final String name;
  final Gender gender;
  final List<Preference>? preferences; // Uniquement pour "Entre Ami(e)s"

  const PlayerModel({
    required this.id,
    required this.name,
    required this.gender,
    this.preferences,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender.name,
      'preferences': preferences?.map((e) => e.name).join(','),
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      gender: Gender.values.firstWhere((e) => e.name == map['gender']),
      preferences: map['preferences'] != null
          ? (map['preferences'] as String)
          .split(',')
          .map((e) => Preference.values.firstWhere((p) => p.name == e))
          .toList()
          : null,
    );
  }

  String get genderEmoji => gender == Gender.homme ? '👨' : '👩';

  String get initials => name.isNotEmpty ? name[0].toUpperCase() : '?';

  PlayerModel copyWith({
    String? id,
    String? name,
    Gender? gender,
    List<Preference>? preferences,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      preferences: preferences ?? this.preferences,
    );
  }
}