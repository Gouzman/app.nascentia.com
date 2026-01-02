import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';
import 'pages/download_page.dart';

/// Widget principal de l'application NASCENTIA
class NascentiaApp extends StatelessWidget {
  const NascentiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASCENTIA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/download': (context) => const DownloadPage(),
      },
    );
  }
}
