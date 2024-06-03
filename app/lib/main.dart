import 'package:app/models/auth.dart';
import 'package:app/models/user.dart';
import 'package:app/views/signup/signup.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize user model
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
      path: '/signup',
      builder: (context, state) => const SageSignUp(),
    ),
    GoRoute(
      path: '/registering',
      builder: (context, state) => const Center(
        child: Text('Hi!'),
      ),
    ),
  ],
  redirect: (context, state) {
    var authModel = Provider.of<AuthModel>(context);
    if (authModel.status == AuthStatus.unknown) {
      return '/signup';
    }
    if (authModel.status == AuthStatus.registering) {
      return '/registering';
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
