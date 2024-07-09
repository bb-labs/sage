import 'package:app/models/camera.dart';
import 'package:app/models/feed.dart';
import 'package:app/models/location.dart';
import 'package:app/models/navigation.dart';
import 'package:app/models/player.dart';
import 'package:app/models/register.dart';
import 'package:app/models/user.dart';
import 'package:app/views/home/home.dart';
import 'package:app/views/login/login.dart';
import 'package:app/views/intro/intro.dart';
import 'package:app/views/registration/reel/reel.dart';
import 'package:app/views/registration/registration.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => FeedModel()),
        ChangeNotifierProvider(create: (context) => CameraModel()),
        ChangeNotifierProvider(create: (context) => PlayerModel()),
        ChangeNotifierProvider(create: (context) => LocationModel()),
        ChangeNotifierProvider(create: (context) => NavigationModel()),
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
      path: '/reel',
      builder: (context, state) => const SageCreateYourReel(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const SageHome(),
    ),
  ],
  onException: (context, state, router) => router.go('/home'),
  redirect: (context, state) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    if (userModel.id.isEmpty) {
      return '/login';
    }

    return null;
  },
);

class SageApp extends StatelessWidget {
  const SageApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);

    return FutureBuilder(
        future: userModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return MaterialApp.router(
            routerConfig: _router,
          );
        });
  }
}
