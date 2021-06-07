import 'package:chopper_demo/ui/post/block/home_bloc.dart';
import 'package:chopper_demo/ui/post/screen/home_screen.dart';
import 'package:chopper_demo/util/di/injection_container.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<BlocHome>(
        create: (context) => serviceLocator<BlocHome>(),
        child: HomeScreen(),
      );
}
