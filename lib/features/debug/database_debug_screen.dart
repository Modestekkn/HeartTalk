import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' show Sqflite;
import '../../core/database/database_helper.dart';

/// Écran de debug pour vérifier le contenu de la base de données enrichie
///
/// Cet écran permet de :
/// - Voir le nombre total de questions et sujets
/// - Voir la distribution par niveau de difficulté
/// - Réinitialiser la base de données si nécessaire
class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> {
  Map<String, dynamic>? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);

    final db = await DatabaseHelper.instance.database;

    // Compter les questions
    final questionsCount =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM questions'),
        ) ??
        0;

    final questionsLevel1 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM questions WHERE level = 1'),
        ) ??
        0;

    final questionsLevel2 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM questions WHERE level = 2'),
        ) ??
        0;

    final questionsLevel3 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM questions WHERE level = 3'),
        ) ??
        0;

    // Compter les sujets
    final topicsCount =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM topics'),
        ) ??
        0;

    final topicsLevel1 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM topics WHERE level = 1'),
        ) ??
        0;

    final topicsLevel2 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM topics WHERE level = 2'),
        ) ??
        0;

    final topicsLevel3 =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM topics WHERE level = 3'),
        ) ??
        0;

    // Compter par catégorie
    final coupleQuestions =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM questions WHERE category_id = "couple"',
          ),
        ) ??
        0;

    final amoureuxQuestions =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM questions WHERE category_id = "amoureux"',
          ),
        ) ??
        0;

    final amisQuestions =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM questions WHERE category_id = "amis"',
          ),
        ) ??
        0;

    final coupleTopics =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM topics WHERE category_id = "couple"',
          ),
        ) ??
        0;

    final amoureuxTopics =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM topics WHERE category_id = "amoureux"',
          ),
        ) ??
        0;

    final amisTopics =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM topics WHERE category_id = "amis"',
          ),
        ) ??
        0;

    setState(() {
      _stats = {
        'questions': {
          'total': questionsCount,
          'level1': questionsLevel1,
          'level2': questionsLevel2,
          'level3': questionsLevel3,
          'couple': coupleQuestions,
          'amoureux': amoureuxQuestions,
          'amis': amisQuestions,
        },
        'topics': {
          'total': topicsCount,
          'level1': topicsLevel1,
          'level2': topicsLevel2,
          'level3': topicsLevel3,
          'couple': coupleTopics,
          'amoureux': amoureuxTopics,
          'amis': amisTopics,
        },
      };
      _isLoading = false;
    });
  }

  Future<void> _resetDatabase() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser la base de données ?'),
        content: const Text(
          'Cette action va supprimer toutes les données et recréer la base avec les données enrichies.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Réinitialiser'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await DatabaseHelper.instance.resetDatabase();
      await _loadStats();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Base de données réinitialisée avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug - Base de données'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
            tooltip: 'Recharger les stats',
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _resetDatabase,
            tooltip: 'Réinitialiser la base',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stats == null
          ? const Center(child: Text('Erreur de chargement'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsCard(
                    'Questions',
                    _stats!['questions'] as Map<String, dynamic>,
                    Icons.help_outline,
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildStatsCard(
                    'Sujets de discussion',
                    _stats!['topics'] as Map<String, dynamic>,
                    Icons.chat_bubble_outline,
                    Colors.purple,
                  ),
                  const SizedBox(height: 24),
                  _buildExpectedValues(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsCard(
    String title,
    Map<String, dynamic> stats,
    IconData icon,
    Color color,
  ) {
    final total = stats['total'] as int;
    final level1 = stats['level1'] as int;
    final level2 = stats['level2'] as int;
    final level3 = stats['level3'] as int;
    final couple = stats['couple'] as int;
    final amoureux = stats['amoureux'] as int;
    final amis = stats['amis'] as int;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            const Divider(height: 24),

            // Total
            _buildStatRow('Total', total, Colors.black, isBold: true),
            const SizedBox(height: 12),

            // Par niveau
            Text(
              'Par niveau de difficulté',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildStatRow('Niveau 1 (Facile)', level1, Colors.green),
            _buildStatRow('Niveau 2 (Moyen)', level2, Colors.orange),
            _buildStatRow('Niveau 3 (Difficile)', level3, Colors.red),
            const SizedBox(height: 12),

            // Par catégorie
            Text(
              'Par catégorie',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildStatRow('🌹 En Couple', couple, const Color(0xFFE63946)),
            _buildStatRow('💕 En Amoureux', amoureux, const Color(0xFF9B59B6)),
            _buildStatRow('👥 Entre Ami(e)s', amis, const Color(0xFF4ECDC4)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    int value,
    Color color, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color),
            ),
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpectedValues() {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Text(
                  'Valeurs Attendues',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              '✅ Questions totales : 270',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '✅ Questions par catégorie : 90',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '✅ Questions par niveau : 90',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text('✅ Sujets totaux : 135', style: TextStyle(fontSize: 16)),
            const Text(
              '✅ Sujets par catégorie : 45',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '✅ Sujets par niveau : 45',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
