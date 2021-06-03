import 'package:chopper_demo/constant/strings.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:flutter/services.dart';

import 'mock_server.dart';

typedef MethodResponse<T> = void Function(T value);

enum Environment { dev, mock, production }

class AppConfig {
  Environment flavor;
  final String apiBaseUrl;

  AppConfig({required this.flavor, required this.apiBaseUrl});

  static late AppConfig _instance;

  static Future<void> configure(MethodResponse fn) async {
    try {

       String? flavor  = Environment.dev.toString();
 /*      flavor = await MethodChannel(AppStrings.channel.kApp)
           .invokeMethod<String>(AppStrings.channelMethod.kFlavor);

      if (flavor == null) return fn(false);*/

      log.info('STARTED WITH FLAVOR $flavor');
      _setupEnvironment(flavor);
      fn(true);
    } catch (e) {
      log.severe("Failed: '${e.toString()}'.");
      log.severe('FAILED TO LOAD FLAVOR');
      fn(false);
    }
  }

  static void _setupEnvironment(String flavorName) async {
    late String baseUrl;
    late Environment flavor;
    if (flavorName == Environment.dev.toString()) {
      baseUrl = AppStrings.serverURLs.dev;
      flavor = Environment.dev;
    } else if (flavorName == Environment.production.toString()) {
      baseUrl = AppStrings.serverURLs.production;
      flavor = Environment.production;
    } else if (flavorName == Environment.mock.toString()) {
      await MockServer.configure();
      baseUrl = MockServer.getInstance().baseUrl;
      flavor = Environment.mock;
    }

    _instance = AppConfig(flavor: flavor, apiBaseUrl: baseUrl);
    log.info('APP CONFIGURED FOR: $flavorName');
  }

  static AppConfig getInstance() => _instance;
}
