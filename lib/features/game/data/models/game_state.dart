import '../../../players/data/models/player_model.dart';
import '../../../category/data/models/category_model.dart';
import 'question_model.dart';
import 'topic_model.dart';

/// Enum représentant les différentes phases du jeu
enum GamePhase {
  /// Phase initiale - Chargement
  idle,

  /// Écran de sélection (Question ou Sujet)
  selection,

  /// Affichage d'une question
  question,

  /// Affichage d'un sujet avec timer
  topic,

  /// Transition entre joueurs
  transition,

  /// Jeu en pause
  paused,

  /// Jeu terminé
  finished,
}

/// Classe représentant l'état complet du jeu
class GameState {
  /// ID unique de la session de jeu
  final String? sessionId;

  /// Catégorie sélectionnée pour cette partie
  final CategoryModel? category;

  /// Liste de tous les joueurs
  final List<PlayerModel> players;

  /// Joueur actuellement actif
  final PlayerModel? currentPlayer;

  /// Question actuellement affichée
  final QuestionModel? currentQuestion;

  /// Sujet actuellement affiché
  final TopicModel? currentTopic;

  /// Phase actuelle du jeu
  final GamePhase phase;

  /// IDs des questions déjà utilisées dans cette session
  final List<String> usedQuestionIds;

  /// IDs des sujets déjà utilisés dans cette session
  final List<String> usedTopicIds;

  /// Temps restant pour le timer (en secondes) si sujet actif
  final int? remainingTime;

  /// Indique si le timer est en pause
  final bool isTimerPaused;

  const GameState({
    this.sessionId,
    this.category,
    this.players = const [],
    this.currentPlayer,
    this.currentQuestion,
    this.currentTopic,
    this.phase = GamePhase.idle,
    this.usedQuestionIds = const [],
    this.usedTopicIds = const [],
    this.remainingTime,
    this.isTimerPaused = false,
  });

  /// Créer une copie de GameState avec des valeurs modifiées
  GameState copyWith({
    String? sessionId,
    CategoryModel? category,
    List<PlayerModel>? players,
    PlayerModel? currentPlayer,
    QuestionModel? currentQuestion,
    TopicModel? currentTopic,
    GamePhase? phase,
    List<String>? usedQuestionIds,
    List<String>? usedTopicIds,
    int? remainingTime,
    bool? isTimerPaused,
  }) {
    return GameState(
      sessionId: sessionId ?? this.sessionId,
      category: category ?? this.category,
      players: players ?? this.players,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentTopic: currentTopic ?? this.currentTopic,
      phase: phase ?? this.phase,
      usedQuestionIds: usedQuestionIds ?? this.usedQuestionIds,
      usedTopicIds: usedTopicIds ?? this.usedTopicIds,
      remainingTime: remainingTime ?? this.remainingTime,
      isTimerPaused: isTimerPaused ?? this.isTimerPaused,
    );
  }

  /// Réinitialiser l'état du jeu
  GameState reset() {
    return const GameState();
  }

  /// Vérifier si le jeu est actif
  bool get isActive =>
      phase != GamePhase.idle &&
      phase != GamePhase.finished &&
      sessionId != null;

  /// Vérifier si on peut passer au joueur suivant
  bool get canProceedToNext =>
      (phase == GamePhase.question || phase == GamePhase.topic) &&
      currentPlayer != null;

  @override
  String toString() {
    return 'GameState(sessionId: $sessionId, phase: $phase, players: ${players.length}, currentPlayer: ${currentPlayer?.name})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameState &&
        other.sessionId == sessionId &&
        other.category == category &&
        other.currentPlayer == currentPlayer &&
        other.phase == phase;
  }

  @override
  int get hashCode {
    return sessionId.hashCode ^
        category.hashCode ^
        currentPlayer.hashCode ^
        phase.hashCode;
  }
}
