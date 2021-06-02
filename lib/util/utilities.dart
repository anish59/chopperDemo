import 'dart:convert';

import 'package:chopper_demo/constant/strings.dart';
import 'package:flutter/services.dart' show MethodChannel, rootBundle;

import 'logger.dart';

class Utilities {
  static Future<String> parseStringFromAssets(String assetsPath) {
    log.info('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath);
  }

  static Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) {
    log.info('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static Future<List<dynamic>> parseJsonArrayFromAssets(String assetsPath) {
    log.info('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static Future<String?> getDeviceIdentifier() async {
    final String? deviceId = await MethodChannel(AppStrings.channel.kApp)
        .invokeMethod<String>(AppStrings.channelMethod.kDeviceId);
    return deviceId;
  }
}
