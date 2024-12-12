import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hatphi_test/presentation/pages/home/contact_info.dart';

import '../main.dart';
import '../presentation/pages/home/home.dart';
import '../presentation/pages/splash_screen.dart';
import '../utils/constants.dart';

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

class AppRouterConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: '/',
    // observers: [BotToastNavigatorObserver()],
    errorBuilder: (context, state) => const SizedBox(
      child: Center(
        child: Text('Error'),
      ),
    ),
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: appNavigatorKey,
        path: '/',
        name: Constants.splashScreen,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
              context: context, state: state, child: const SplashScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: appNavigatorKey,
        path: Constants.home,
        name: Constants.home,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const Home(),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: appNavigatorKey,
        path: Constants.contactScreen,
        name: Constants.contactScreen,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ContactInfoPage(),
          );
        },
      ),
    ],
  );
}
