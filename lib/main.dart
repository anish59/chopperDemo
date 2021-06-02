import 'package:chopper_demo/post/home_page.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/app_config.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  loggerConfigure();
  await AppConfig.configure((isSuccess) => runApp(MyApp(
        isConfigurationError: isSuccess,
      )));
}

class MyApp extends StatelessWidget {
  final bool isConfigurationError;

  const MyApp({Key? key, required this.isConfigurationError}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostApiService.create(),
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Material App',
        home: isConfigurationError ? HomePage() : buildErrorWidget(),
      ),
    );
  }

  Center buildErrorWidget() {
    return Center(
      child: Text('App Configuration failed'),
    );
  }
}
