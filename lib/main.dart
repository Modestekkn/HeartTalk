import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heartalk/core/router/app_router.dart';

void main() {
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
