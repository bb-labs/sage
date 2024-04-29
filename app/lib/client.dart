import 'package:app/auth.dart';
import 'package:grpc/grpc.dart';
import 'package:app/pb/sage.pbgrpc.dart';

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
      isProduction ? 'app.sage.dating' : '192.168.1.132',
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
