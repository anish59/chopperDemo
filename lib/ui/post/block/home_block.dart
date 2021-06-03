import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/home_event.dart';
import 'package:chopper_demo/ui/post/block/home_state.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlock extends Bloc<HomeEvent, HomeState> {
  final PostApiService client;

  HomeBlock({required this.client}) : super(HomeStateLoading());

  @override
  HomeState get state => HomeStateLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is HomeEventGetAllPost) {
        yield HomeStateLoading();

        Response<BuiltList<BuiltPost>> allPost = await client.getPosts();

        // safe accessing the value
        yield HomeStateGettingAllPost(allPost.body?.toList() ?? []);
      } else if (event is HomeEventOpenPostDetail) {
        yield HomeStateOpenPost(event.postId);
      }
    } catch (e) {
      print(e);
      log.severe("HomeBlockError: ${e.toString()}");
      yield HomeStateErrorOccurred(e.toString());
    }
  }
}
