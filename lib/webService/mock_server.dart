import 'dart:io';

import 'package:chopper_demo/constant/strings.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/util/utilities.dart';

class MockServer {
  static late MockServer _instance;

  final String baseUrl;
  final HttpServer server;

  MockServer({required this.baseUrl, required this.server});

  static Future<void> configure() async {
    var server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      3003,
    );
    log.info('Listening on ${server.address.address}:${server.port}');
    final baseUrl = 'http://${server.address.address}:${server.port}';
    _instance = MockServer(baseUrl: baseUrl, server: server);
    _instance._startListening();
  }

  void _startListening() async {
    await for (HttpRequest request in server) {
      String url = request.uri.path;
      dynamic response;
      try {
        if (url.endsWith(AppApis.getAllPost)) {
          response = await (Utilities.parseStringFromAssets(
              AppStrings.mockAssets.kGetAllPost));
          /*
                var loginFail = await (Utilities.parseStringFromAssets(Mock.kFailure));
                response = loginFail;
                request.response.statusCode = HttpStatus.unauthorized;
               */
        } else {
          var failure = await (Utilities.parseStringFromAssets(
              AppStrings.mockAssets.kErrorResponse));
          request.response.statusCode = HttpStatus.badRequest;
          response = failure;
        }
      } catch (e) {
        log.severe(e);
      }
      request.response
        ..write(response)
        ..close();
    }
  }

  static MockServer getInstance() => _instance;
}
