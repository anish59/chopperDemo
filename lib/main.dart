import 'package:chopper_demo/ui/post/screen/home_page.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/app_config.dart';
import 'package:flutter/material.dart';

import 'di/injection_container.dart';

Future<void> main() async {
  loggerConfigure();
  await initInjection();
  await AppConfig.configure((isSuccess) => runApp(MyApp(
        isConfigurationSuccess: isSuccess,
      )));
}

class MyApp extends StatelessWidget {
  final bool isConfigurationSuccess;

  const MyApp({Key? key, required this.isConfigurationSuccess})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: isConfigurationSuccess ? HomePage() : buildErrorWidget(),
    );
  }

  Center buildErrorWidget() {
    return Center(
      child: Text('App Configuration failed'),
    );
  }
}
