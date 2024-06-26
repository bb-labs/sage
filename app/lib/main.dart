import 'package:app/models/auth.dart';
import 'package:app/models/camera.dart';
import 'package:app/models/location.dart';
import 'package:app/models/register.dart';
import 'package:app/models/user.dart';
import 'package:app/views/login/login.dart';
import 'package:app/views/intro/intro.dart';
import 'package:app/views/register/profile/reel/reel.dart';
import 'package:app/views/register/register.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var userModel = UserModel();
  var cameraModel = CameraModel();
  var locationModel = LocationModel();
  await userModel.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthModel(userModel.user)),
        ChangeNotifierProvider(create: (context) => userModel),
        ChangeNotifierProvider(create: (context) => cameraModel),
        ChangeNotifierProvider(create: (context) => locationModel),
        ChangeNotifierProvider(create: (context) => RegistrationModel()),
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
    GoRoute(
      path: '/profile',
      builder: (context, state) => const SageCreateYourReel(),
    ),
  ],
  onException: (context, state, router) => router.go('/profile'),
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
