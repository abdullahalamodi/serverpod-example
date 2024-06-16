import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

// This is the starting point of your Serverpod server.
void run(List<String> args) async {
  final port = int.parse(
      Platform.environment['PORT'] ?? '8080'); // listen on assigned port
  final config = ServerConfig(
    port: port,
    publicScheme: 'https',
    publicHost: 'localhost',
    publicPort: port,
  );
  final webConfig = ServerConfig(
    port: 8082,
    publicScheme: 'https',
    publicHost: 'localhost',
    publicPort: 8082,
  );
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    config: ServerpodConfig(
      apiServer: config,
      webServer: webConfig,
    ),
    Protocol(),
    Endpoints(),
  );

  // Start the server.
  pod.webServer.addRoute(MyRoute(), '/example/hello');
  await pod.start();
}

class MyRoute extends WidgetRoute {
  @override
  Future<AbstractWidget> build(Session session, HttpRequest request) async {
    return WidgetRedirect(url: 'https://example.com');
  }
}
