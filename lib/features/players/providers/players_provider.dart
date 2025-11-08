import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/models/player_model.dart';

// ============================================
// PLAYERS NOTIFIER
// ============================================
class PlayersNotifier extends StateNotifier<List<PlayerModel>> {
  PlayersNotifier() : super([]);

  final _uuid = const Uuid();
  final _random = Random();

  // Ajouter un joueur
  void addPlayer(PlayerModel player) {
    state = [...state, player];
  }

  // Créer et ajouter un nouveau joueur
  void createPlayer({
    required String name,
    required Gender gender,
    List<Preference>? preferences,
  }) {
    final player = PlayerModel(
      id: _uuid.v4(),
      name: name,
      gender: gender,
      preferences: preferences,
    );
    addPlayer(player);
  }

  // Supprimer un joueur
  void removePlayer(String playerId) {
    state = state.where((player) => player.id != playerId).toList();
  }

  // Mettre à jour un joueur
  void updatePlayer(PlayerModel updatedPlayer) {
    state = [
      for (final player in state)
        if (player.id == updatedPlayer.id) updatedPlayer else player,
    ];
  }

  // Réinitialiser la liste des joueurs
  void reset() {
    state = [];
  }

  // Obtenir un joueur aléatoire
  PlayerModel? getRandomPlayer({PlayerModel? exclude}) {
    if (state.isEmpty) return null;

    final availablePlayers = exclude != null
        ? state.where((p) => p.id != exclude.id).toList()
        : state;

    if (availablePlayers.isEmpty) return state[_random.nextInt(state.length)];

    return availablePlayers[_random.nextInt(availablePlayers.length)];
  }

  // Obtenir le joueur suivant (rotation)
  PlayerModel? getNextPlayer(PlayerModel? currentPlayer) {
    if (state.isEmpty) return null;
    if (currentPlayer == null) return state.first;

    final currentIndex = state.indexWhere((p) => p.id == currentPlayer.id);
    if (currentIndex == -1) return state.first;

    final nextIndex = (currentIndex + 1) % state.length;
    return state[nextIndex];
  }
}

// ============================================
// PROVIDERS
// ============================================

// Liste des joueurs
final playersProvider = StateNotifierProvider<PlayersNotifier, List<PlayerModel>>(
      (ref) => PlayersNotifier(),
);

// Joueur actuellement actif dans le jeu
final currentPlayerProvider = StateProvider<PlayerModel?>((ref) => null);

// ============================================
// HELPER PROVIDERS
// ============================================

// Nombre de joueurs
final playersCountProvider = Provider<int>((ref) {
  return ref.watch(playersProvider).length;
});

// Vérifier si on a le minimum de joueurs (2)
final hasMinimumPlayersProvider = Provider<bool>((ref) {
  return ref.watch(playersCountProvider) >= 2;
});

// Vérifier si on peut ajouter plus de joueurs (max 6)
final canAddMorePlayersProvider = Provider<bool>((ref) {
  return ref.watch(playersCountProvider) < 6;
});

// Obtenir un joueur par ID
final playerByIdProvider = Provider.family<PlayerModel?, String>((ref, id) {
  final players = ref.watch(playersProvider);
  try {
    return players.firstWhere((player) => player.id == id);
  } catch (e) {
    return null;
  }
});

// Liste des noms des joueurs (pour affichage)
final playersNamesProvider = Provider<List<String>>((ref) {
  return ref.watch(playersProvider).map((p) => p.name).toList();
});