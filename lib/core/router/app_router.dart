import 'package:go_router/go_router.dart';
import '../../pages/home_page.dart';
import '../../pages/download_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/download',
      builder: (context, state) => const DownloadPage(),
    ),
    ],
);
