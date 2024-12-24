import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatphi_test/theme.dart';

import 'config/router.dart';

final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hatphi Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      routerConfig: AppRouterConfig.router,
    );
  }
}
