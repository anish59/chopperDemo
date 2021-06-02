
import 'package:logging/logging.dart';
import 'dart:developer' as Developer;

void loggerConfigure() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    Developer.log('AppLogger: ${record.level.name} : ${record.time} : ${record
        .message}');
  });
}

final log = Logger('Choper_demo');
