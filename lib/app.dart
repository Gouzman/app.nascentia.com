import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'core/router/app_router.dart';

/// Widget principal de l'application NASCENTIA
class NascentiaApp extends StatelessWidget {
  const NascentiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NASCENTIA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
