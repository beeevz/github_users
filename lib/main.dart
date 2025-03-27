import 'package:flutter/material.dart';
import 'package:github_users/common/routing/github_user_routes.dart';
import 'package:github_users/di/global_register.dart';
import 'package:github_users/di/service_register.dart';
import 'package:github_users/view/theme/github_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  await loadGlobals();
  await GlobalsRegister.register();
  ServiceRegister.register();
  runApp(const MyApp());
}

Future<dynamic> loadGlobals() async {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(routes: GithubUserRoutes.githubUserRoutes),
      theme: lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
