import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heartalk/core/router/app_router.dart';
import 'package:heartalk/core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la base de données (elle sera créée si elle n'existe pas)
  try {
    await DatabaseHelper.instance.database;
    if (kDebugMode) {
      debugPrint('✅ Base de données initialisée');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('⚠️ Erreur lors de l\'initialisation de la base: $e');
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HeartTalk",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splash,
      routes: AppRouter.myroutes,
    );
  }
}
