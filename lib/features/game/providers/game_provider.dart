import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_helper.dart';
import '../data/models/game_state.dart';
import '../data/models/question_model.dart';
import '../data/models/topic_model.dart';
import '../../players/data/models/player_model.dart';
import '../../players/providers/players_provider.dart';
import '../../category/providers/category_provider.dart';

// ============================================
// GAME REPOSITORY
// ============================================
class GameRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<List<QuestionModel>> getQuestions(String categoryId) async {
    final maps = await _db.getQuestionsByCategory(categoryId, onlyUnused: true);
    return maps.map((map) => QuestionModel.fromMap(map)).toList();
  }

  Future<List<TopicModel>> getTopics(String categoryId) async {
    final maps = await _db.getTopicsByCategory(categoryId, onlyUnused: true);
    return maps.map((map) => TopicModel.fromMap(map)).toList();
  }

  Future<void> markQuestionAsUsed(String questionId) async {
    await _db.markQuestionAsUsed(questionId);
  }

  Future<void> markTopicAsUsed(String topicId) async {
    await _db.markTopicAsUsed(topicId);
  }

  Future<String> createSession(
    String categoryId,
    List<PlayerModel> players,
  ) async {
    return await _db.createGameSession(
      categoryId,
      players.map((p) => p.toMap()).toList(),
    );
  }

  Future<void> endSession(String sessionId) async {
    await _db.endGameSession(sessionId);
  }

  Future<void> resetUsedStatus(String categoryId) async {
    await _db.resetUsedStatus(categoryId);
  }
}

// ============================================
// GAME NOTIFIER
// ============================================
class GameNotifier extends StateNotifier<GameState> {
  GameNotifier(this.ref) : super(const GameState());

  final Ref ref;
  final _random = Random();

  // Initialiser une nouvelle partie
  Future<void> startGame() async {
    final category = ref.read(selectedCategoryProvider);
    final players = ref.read(playersProvider);

    if (category == null || players.isEmpty) return;

    // Créer une session
    final repository = ref.read(gameRepositoryProvider);
    final sessionId = await repository.createSession(category.id, players);

    // Sélectionner le premier joueur aléatoirement
    final firstPlayer = players[_random.nextInt(players.length)];
    ref.read(currentPlayerProvider.notifier).state = firstPlayer;

    state = GameState(
      sessionId: sessionId,
      category: category,
      players: players,
      currentPlayer: firstPlayer,
      phase: GamePhase.selection,
    );
  }

  // Charger une question aléatoire
  Future<void> loadQuestion() async {
    if (state.category == null) return;

    final repository = ref.read(gameRepositoryProvider);
    final allQuestions = await repository.getQuestions(state.category!.id);

    // Filtrer les questions non utilisées dans cette session
    final availableQuestions = allQuestions
        .where((q) => !state.usedQuestionIds.contains(q.id))
        .toList();

    if (availableQuestions.isEmpty) {
      // Si plus de questions, réinitialiser
      await repository.resetUsedStatus(state.category!.id);
      return loadQuestion();
    }

    final question =
        availableQuestions[_random.nextInt(availableQuestions.length)];

    state = state.copyWith(
      currentQuestion: question,
      phase: GamePhase.question,
    );
  }

  // Charger un sujet aléatoire
  Future<void> loadTopic() async {
    if (state.category == null) return;

    final repository = ref.read(gameRepositoryProvider);
    final allTopics = await repository.getTopics(state.category!.id);

    // Filtrer les sujets non utilisés dans cette session
    final availableTopics = allTopics
        .where((t) => !state.usedTopicIds.contains(t.id))
        .toList();

    if (availableTopics.isEmpty) {
      // Si plus de sujets, réinitialiser
      await repository.resetUsedStatus(state.category!.id);
      return loadTopic();
    }

    final topic = availableTopics[_random.nextInt(availableTopics.length)];

    state = state.copyWith(currentTopic: topic, phase: GamePhase.topic);
  }

  // Marquer la question actuelle comme utilisée et passer au joueur suivant
  Future<void> nextQuestion() async {
    if (state.currentQuestion == null) return;

    final repository = ref.read(gameRepositoryProvider);
    await repository.markQuestionAsUsed(state.currentQuestion!.id);

    // Ajouter à la liste des questions utilisées
    state = state.copyWith(
      usedQuestionIds: [...state.usedQuestionIds, state.currentQuestion!.id],
    );

    await _selectNextPlayer();
  }

  // Marquer le sujet actuel comme utilisé et passer au joueur suivant
  Future<void> nextTopic() async {
    if (state.currentTopic == null) return;

    final repository = ref.read(gameRepositoryProvider);
    await repository.markTopicAsUsed(state.currentTopic!.id);

    // Ajouter à la liste des sujets utilisés
    state = state.copyWith(
      usedTopicIds: [...state.usedTopicIds, state.currentTopic!.id],
    );

    await _selectNextPlayer();
  }

  // Sélectionner le joueur suivant aléatoirement
  Future<void> _selectNextPlayer() async {
    if (state.players.isEmpty) return;

    state = state.copyWith(phase: GamePhase.transition);

    // Attendre un peu pour l'animation
    await Future.delayed(const Duration(milliseconds: 300));

    // Sélectionner un joueur aléatoire (peut être le même)
    final nextPlayer = state.players[_random.nextInt(state.players.length)];
    ref.read(currentPlayerProvider.notifier).state = nextPlayer;

    state = state.copyWith(
      currentPlayer: nextPlayer,
      phase: GamePhase.selection,
      currentQuestion: null,
      currentTopic: null,
    );
  }

  // Terminer la partie
  Future<void> endGame() async {
    if (state.sessionId != null) {
      final repository = ref.read(gameRepositoryProvider);
      await repository.endSession(state.sessionId!);
    }

    // Réinitialiser l'état
    ref.read(currentPlayerProvider.notifier).state = null;
    state = const GameState();
  }

  // Recommencer la partie
  Future<void> restartGame() async {
    await endGame();
    await startGame();
  }

  // Passer le tour (skip)
  Future<void> skipTurn() async {
    await _selectNextPlayer();
  }

  // Réinitialiser complètement le jeu (quand on revient en arrière)
  void resetGame() {
    ref.read(currentPlayerProvider.notifier).state = null;
    state = const GameState();
  }
}

// ============================================
// PROVIDERS
// ============================================

// Repository
final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository();
});

// Game State
final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(ref);
});

// Questions disponibles pour la catégorie actuelle
final questionsProvider = FutureProvider<List<QuestionModel>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  if (category == null) return [];

  final repository = ref.read(gameRepositoryProvider);
  return await repository.getQuestions(category.id);
});

// Sujets disponibles pour la catégorie actuelle
final topicsProvider = FutureProvider<List<TopicModel>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  if (category == null) return [];

  final repository = ref.read(gameRepositoryProvider);
  return await repository.getTopics(category.id);
});

// ============================================
// HELPER PROVIDERS
// ============================================

// Vérifier si le jeu est actif
final isGameActiveProvider = Provider<bool>((ref) {
  return ref.watch(gameProvider).isActive;
});

// Phase actuelle du jeu
final currentGamePhaseProvider = Provider<GamePhase>((ref) {
  return ref.watch(gameProvider).phase;
});

// Question actuelle
final currentQuestionProvider = Provider<QuestionModel?>((ref) {
  return ref.watch(gameProvider).currentQuestion;
});

// Sujet actuel
final currentTopicProvider = Provider<TopicModel?>((ref) {
  return ref.watch(gameProvider).currentTopic;
});
