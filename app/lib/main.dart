import 'package:grpc/grpc.dart';
import 'package:app/pb/sage.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/signup/signup.dart';

class SageClientSingleton {
  late SageClient client;

  SageClientSingleton._privateConstructor() {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');

    final channel = ClientChannel(
      isProduction ? 'app.sage.dating' : 'localhost',
      port: isProduction ? 443 : 3000,
      options: const ChannelOptions(
        credentials: isProduction
            ? ChannelCredentials.secure()
            : ChannelCredentials.insecure(),
      ),
    );

    client = SageClient(channel);
  }

  static final SageClientSingleton instance =
      SageClientSingleton._privateConstructor();
}

void main() {
  runApp(const ProviderScope(child: SageApp()));
}

class SageApp extends StatelessWidget {
  const SageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SageSignUp(),
        ),
      ),
    );
  }
}
