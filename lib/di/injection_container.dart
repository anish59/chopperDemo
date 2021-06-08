import 'package:chopper_demo/ui/post/block/bloc_post_list.dart';
import 'package:chopper_demo/ui/post/block/home_bloc.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_bloc.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initInjection() async {
  //Api Clients
  try {
    serviceLocator.registerLazySingleton(() => PostApiClient.create());

    //blocs
    serviceLocator.registerFactory(() => BlocHome(client: serviceLocator<PostApiClient>()));
    serviceLocator.registerFactory(() => BlocPostDetail(client: serviceLocator<PostApiClient>()));
    serviceLocator.registerFactory(() => BlocPostList(client: serviceLocator<PostApiClient>()));

  } on Exception catch (e) {
    log.severe(e.toString());
  }

  // other things can also come like shared preference, firebase instance
}
