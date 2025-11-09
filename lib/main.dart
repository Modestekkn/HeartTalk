import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heartalk/core/router/app_router.dart';
import 'package:heartalk/core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TEMPORAIRE: Supprimer l'ancienne base de données pour corriger l'erreur de schéma
  try {
    await DatabaseHelper.instance.deleteDatabase();
    if (kDebugMode) {
      debugPrint('✅ Ancienne base de données supprimée');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('⚠️ Erreur lors de la suppression de la base: $e');
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
