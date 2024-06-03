import 'package:grpc/grpc.dart';
import 'package:app/network/interceptors/auth.dart';
import 'package:app/proto/sage.pbgrpc.dart';

class SageClientSingleton {
  static final SageClientSingleton _instance =
      SageClientSingleton._privateConstructor();

  factory SageClientSingleton() {
    return _instance;
  }

  late SageClient instance;

  SageClientSingleton._privateConstructor() {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');

    final channel = ClientChannel(
      isProduction ? 'app.sage.dating' : '192.168.7.61',
      port: isProduction ? 443 : 3000,
      options: const ChannelOptions(
        credentials: isProduction
            ? ChannelCredentials.secure()
            : ChannelCredentials.insecure(),
      ),
    );

    instance = SageClient(channel, interceptors: [SageAuthInterceptor()]);
  }
}
