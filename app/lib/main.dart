import 'package:app/app.dart';
import 'package:grpc/grpc.dart';
import 'package:app/pb/sage.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SageClientSingleton {
  late SageClient client;

  static final SageClientSingleton _instance =
      SageClientSingleton._privateConstructor();

  factory SageClientSingleton() {
    return _instance;
  }

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
}

void main() {
  runApp(const ProviderScope(child: SageApp()));
}
