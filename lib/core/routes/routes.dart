import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hookadoc_server/core/routes/route_names.dart';
import 'package:hookadoc_server/features/presentation/home%20page/view/page.dart';
import 'package:hookadoc_server/features/presentation/profile%20page/view/page.dart';
import 'package:hookadoc_server/features/presentation/qr_code%20scan%20page/view/page.dart';
import 'package:hookadoc_server/features/presentation/schedules%20page/view/page.dart';

class Routes {
  static final route = GoRouter(
    initialLocation: RouteNames.homePage,
    routes: [
      GoRoute(
        path: RouteNames.homePage,
        builder: (context, state) => const HomePage(),
        pageBuilder: (context, state) =>
            _customTransitionPage(page: const HomePage()),
      ),
      GoRoute(
        path: RouteNames.schedulesPage,
        builder: (context, state) => const SchedulesPage(),
        pageBuilder: (context, state) =>
            _customTransitionPage(page: const SchedulesPage()),
      ),
      GoRoute(
        path: RouteNames.profilePage,
        builder: (context, state) => const ProfilePage(),
        pageBuilder: (context, state) =>
            _customTransitionPage(page: const ProfilePage()),
      ),
      GoRoute(
        path: RouteNames.qrScanPage,
        builder: (context, state) => const QrCodeScanPage(),
        pageBuilder: (context, state) =>
            _customTransitionPage(page: const QrCodeScanPage()),
      )
    ],
  );
}

CustomTransitionPage _customTransitionPage({
  required Widget page,
}) =>
    CustomTransitionPage(
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
