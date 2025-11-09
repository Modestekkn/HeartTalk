import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'database_enriched_data.dart';
import 'database_enriched_topics.dart';

/// Helper pour gérer la base de données SQLite
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('heartalk.db');
    return _database!;
  }

  // Méthode pour supprimer complètement la base de données
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'heartalk.db');
    await _database?.close();
    _database = null;
    await databaseFactory.deleteDatabase(path);
  }

  // Méthode pour réinitialiser la base de données
  Future<void> resetDatabase() async {
    await deleteDatabase();
    _database = await _initDB('heartalk.db');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3, // Incrémenté pour enrichissement Phase B
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // Supprimer et recréer les tables
      await db.execute('DROP TABLE IF EXISTS game_sessions');
      await db.execute('DROP TABLE IF EXISTS topics');
      await db.execute('DROP TABLE IF EXISTS questions');
      await db.execute('DROP TABLE IF EXISTS categories');
      await _createDB(db, newVersion);
    }
  }

  Future<void> _createDB(Database db, int version) async {
    // ========== TABLE: CATEGORIES ==========
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        emoji TEXT NOT NULL,
        description TEXT NOT NULL,
        primary_color TEXT NOT NULL,
        secondary_color TEXT NOT NULL
      )
    ''');

    // ========== TABLE: QUESTIONS ==========
    await db.execute('''
      CREATE TABLE questions (
        id TEXT PRIMARY KEY,
        category_id TEXT NOT NULL,
        text TEXT NOT NULL,
        level INTEGER DEFAULT 1,
        is_used INTEGER DEFAULT 0,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // ========== TABLE: TOPICS ==========
    await db.execute('''
      CREATE TABLE topics (
        id TEXT PRIMARY KEY,
        category_id TEXT NOT NULL,
        text TEXT NOT NULL,
        duration INTEGER DEFAULT 300,
        level INTEGER DEFAULT 1,
        is_used INTEGER DEFAULT 0,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // ========== TABLE: GAME_SESSIONS ==========
    await db.execute('''
      CREATE TABLE game_sessions (
        id TEXT PRIMARY KEY,
        category_id TEXT NOT NULL,
        players TEXT NOT NULL,
        started_at INTEGER NOT NULL,
        ended_at INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // ========== INSERTION DES DONNÉES INITIALES ==========
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    const uuid = Uuid();

    // ========== CATÉGORIES ==========
    final categories = [
      {
        'id': 'couple',
        'name': 'En Couple',
        'emoji': 'assets/icons/couple.png',
        'description': 'Renforcez votre complicité avec des questions intimes',
        'primary_color': '4294198598', // 0xFFE63946
        'secondary_color': '4294943645', // 0xFFFF6B9D
      },
      {
        'id': 'amoureux',
        'name': 'En Amoureux',
        'emoji': 'assets/icons/lovers.png',
        'description': 'Apprenez à vous connaître en profondeur',
        'primary_color': '4287245494', // 0xFF9B59B6
        'secondary_color': '4294943645', // 0xFFFF6B9D
      },
      {
        'id': 'amis',
        'name': 'Entre Ami(e)s',
        'emoji': 'assets/icons/friends.png',
        'description': 'Fun et découverte entre amis',
        'primary_color': '4291559876', // 0xFF4ECDC4
        'secondary_color': '4284761229', // 0xFF44A08D
      },
    ];

    for (var category in categories) {
      await db.insert('categories', category);
    }

    // ========== QUESTIONS ENRICHIES - PHASE B ==========

    // Questions EN COUPLE (90 nouvelles)
    for (var questionData in DatabaseEnrichedData.coupleQuestionsNew) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'couple',
        'text': questionData['text'],
        'level': questionData['level'],
        'is_used': 0,
      });
    }

    // Questions EN AMOUREUX (90 nouvelles)
    for (var questionData in DatabaseEnrichedData.amoureuxQuestionsNew) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'amoureux',
        'text': questionData['text'],
        'level': questionData['level'],
        'is_used': 0,
      });
    }

    // Questions ENTRE AMIS (90 nouvelles)
    for (var questionData in DatabaseEnrichedData.amisQuestionsNew) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'amis',
        'text': questionData['text'],
        'level': questionData['level'],
        'is_used': 0,
      });
    }

    // ========== SUJETS ENRICHIS - PHASE B ==========

    // Sujets EN COUPLE (45 nouveaux)
    for (var topicData in DatabaseEnrichedTopics.coupleTopicsNew) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'couple',
        'text': topicData['text'],
        'duration': topicData['duration'],
        'level': topicData['level'],
        'is_used': 0,
      });
    }

    // Sujets EN AMOUREUX (45 nouveaux)
    for (var topicData in DatabaseEnrichedTopics.amoureuxTopicsNew) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'amoureux',
        'text': topicData['text'],
        'duration': topicData['duration'],
        'level': topicData['level'],
        'is_used': 0,
      });
    }

    // Sujets ENTRE AMIS (45 nouveaux)
    for (var topicData in DatabaseEnrichedTopics.amisTopicsNew) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'amis',
        'text': topicData['text'],
        'duration': topicData['duration'],
        'level': topicData['level'],
        'is_used': 0,
      });
    }
  }

  // ========== MÉTHODES CRUD ==========

  /// Récupérer toutes les catégories
  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return await db.query('categories');
  }

  /// Récupérer les questions par catégorie
  Future<List<Map<String, dynamic>>> getQuestionsByCategory(
    String categoryId, {
    bool onlyUnused = false,
  }) async {
    final db = await database;
    return await db.query(
      'questions',
      where: onlyUnused ? 'category_id = ? AND is_used = 0' : 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'RANDOM()',
    );
  }

  /// Récupérer les sujets par catégorie
  Future<List<Map<String, dynamic>>> getTopicsByCategory(
    String categoryId, {
    bool onlyUnused = false,
  }) async {
    final db = await database;
    return await db.query(
      'topics',
      where: onlyUnused ? 'category_id = ? AND is_used = 0' : 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'RANDOM()',
    );
  }

  /// Marquer une question comme utilisée
  Future<void> markQuestionAsUsed(String questionId) async {
    final db = await database;
    await db.update(
      'questions',
      {'is_used': 1},
      where: 'id = ?',
      whereArgs: [questionId],
    );
  }

  /// Marquer un sujet comme utilisé
  Future<void> markTopicAsUsed(String topicId) async {
    final db = await database;
    await db.update(
      'topics',
      {'is_used': 1},
      where: 'id = ?',
      whereArgs: [topicId],
    );
  }

  /// Réinitialiser toutes les questions/sujets comme non utilisés
  Future<void> resetUsedStatus(String categoryId) async {
    final db = await database;
    await db.update(
      'questions',
      {'is_used': 0},
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    await db.update(
      'topics',
      {'is_used': 0},
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  /// Créer une nouvelle session de jeu
  Future<String> createGameSession(
    String categoryId,
    List<Map<String, dynamic>> players,
  ) async {
    final db = await database;
    const uuid = Uuid();
    final sessionId = uuid.v4();

    await db.insert('game_sessions', {
      'id': sessionId,
      'category_id': categoryId,
      'players': players.toString(),
      'started_at': DateTime.now().millisecondsSinceEpoch,
    });

    return sessionId;
  }

  /// Terminer une session de jeu
  Future<void> endGameSession(String sessionId) async {
    final db = await database;
    await db.update(
      'game_sessions',
      {'ended_at': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [sessionId],
    );
  }

  /// Fermer la base de données
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
