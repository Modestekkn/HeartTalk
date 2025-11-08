import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

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

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // ========== TABLE: CATEGORIES ==========
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        image TEXT NOT NULL,
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

    // ========== QUESTIONS - EN COUPLE ==========
    final coupleQuestions = [
      'Quelle est la chose que tu admires le plus chez moi ?',
      'Quel est ton souvenir préféré de nous deux ?',
      'Comment vois-tu notre relation dans 5 ans ?',
      'Qu\'est-ce qui te fait te sentir le plus aimé(e) dans notre relation ?',
      'Quelle est ta façon préférée de passer du temps avec moi ?',
      'Y a-t-il quelque chose que tu aimerais améliorer dans notre relation ?',
      'Quel est le moment où tu t\'es senti(e) le plus proche de moi ?',
      'Qu\'est-ce qui t\'a fait tomber amoureux/amoureuse de moi ?',
      'Quelle est ta plus grande peur concernant notre relation ?',
      'Comment puis-je mieux te soutenir au quotidien ?',
    ];

    for (var question in coupleQuestions) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'couple',
        'text': question,
        'level': 1,
        'is_used': 0,
      });
    }

    // ========== QUESTIONS - EN AMOUREUX ==========
    final amoureuxQuestions = [
      'Qu\'est-ce qui t\'attire le plus chez une personne ?',
      'Quel est ton type de rendez-vous idéal ?',
      'Quelle est ta vision d\'une relation parfaite ?',
      'Qu\'est-ce qui te fait rire le plus ?',
      'Quel est ton plus grand rêve dans la vie ?',
      'Comment te décrirais-tu en trois mots ?',
      'Quelle est ta plus grande qualité selon toi ?',
      'Qu\'est-ce qui est le plus important pour toi dans une relation ?',
      'Quel est ton film ou livre d\'amour préféré et pourquoi ?',
      'Qu\'est-ce qui te rend heureux/heureuse au quotidien ?',
    ];

    for (var question in amoureuxQuestions) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'amoureux',
        'text': question,
        'level': 1,
        'is_used': 0,
      });
    }

    // ========== QUESTIONS - ENTRE AMIS ==========
    final amisQuestions = [
      'Quelle est la chose la plus folle que tu aies jamais faite ?',
      'Si tu pouvais voyager n\'importe où, où irais-tu ?',
      'Quel est ton super pouvoir préféré et pourquoi ?',
      'Quelle est ta pire anecdote embarrassante ?',
      'Si tu gagnais au loto, quelle serait la première chose que tu ferais ?',
      'Quel est ton talent caché que personne ne connaît ?',
      'Quelle célébrité aimerais-tu rencontrer et pourquoi ?',
      'Quel est le meilleur conseil que tu aies jamais reçu ?',
      'Si tu pouvais dîner avec n\'importe quelle personne, morte ou vivante, qui choisirais-tu ?',
      'Quelle est ta plus grande fierté personnelle ?',
    ];

    for (var question in amisQuestions) {
      await db.insert('questions', {
        'id': uuid.v4(),
        'category_id': 'amis',
        'text': question,
        'level': 1,
        'is_used': 0,
      });
    }

    // ========== SUJETS - EN COUPLE ==========
    final coupleTopics = [
      'Parlez de vos rêves et projets pour les 5 prochaines années',
      'Discutez de ce qui vous rend vraiment heureux dans votre relation',
      'Évoquez un défi que vous avez surmonté ensemble',
      'Partagez vos langages d\'amour préférés',
      'Discutez de vos traditions de couple préférées',
    ];

    for (var topic in coupleTopics) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'couple',
        'text': topic,
        'duration': 300,
        'level': 1,
        'is_used': 0,
      });
    }

    // ========== SUJETS - EN AMOUREUX ==========
    final amoureuxTopics = [
      'Parlez de vos passions et hobbies préférés',
      'Discutez de vos valeurs et principes de vie',
      'Évoquez vos objectifs personnels et professionnels',
      'Partagez vos expériences de voyage favorites',
      'Discutez de ce qui vous fait sentir aimé(e) et apprécié(e)',
    ];

    for (var topic in amoureuxTopics) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'amoureux',
        'text': topic,
        'duration': 300,
        'level': 1,
        'is_used': 0,
      });
    }

    // ========== SUJETS - ENTRE AMIS ==========
    final amisTopics = [
      'Débattez sur un sujet d\'actualité qui vous passionne',
      'Partagez vos meilleures anecdotes de voyage',
      'Discutez de vos séries ou films préférés du moment',
      'Évoquez vos rêves d\'enfance et ce que vous en avez fait',
      'Parlez de ce que vous admirez le plus chez vos amis',
    ];

    for (var topic in amisTopics) {
      await db.insert('topics', {
        'id': uuid.v4(),
        'category_id': 'amis',
        'text': topic,
        'duration': 300,
        'level': 1,
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
      where: onlyUnused
          ? 'category_id = ? AND is_used = 0'
          : 'category_id = ?',
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
      where: onlyUnused
          ? 'category_id = ? AND is_used = 0'
          : 'category_id = ?',
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