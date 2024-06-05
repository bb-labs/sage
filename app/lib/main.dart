import 'package:app/models/auth.dart';
import 'package:app/models/user.dart';
import 'package:app/views/login/login.dart';
import 'package:app/views/intro/intro.dart';
import 'package:app/views/register/register.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize user model (lookup user from storage, fetch from server, etc.)
  var userModel = UserModel();
  await userModel.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthModel(userModel.user)),
        ChangeNotifierProvider(create: (context) => userModel),
      ],
      child: const SageApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const SageLogin(),
    ),
    GoRoute(
      path: '/intro',
      builder: (context, state) => const SageIntroduction(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const SageRegistration(),
    ),
  ],
  onException: (context, state, router) => router.go('/register'),
  redirect: (context, state) {
    var authModel = Provider.of<AuthModel>(context, listen: false);
    if (authModel.status == AuthStatus.unknown) {
      return '/login';
    }
    return null;
  },
);

class SageApp extends StatelessWidget {
  const SageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
