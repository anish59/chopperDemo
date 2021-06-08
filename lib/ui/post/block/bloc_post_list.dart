import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/event_post_list.dart';
import 'package:chopper_demo/ui/post/block/state_post_list.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocPostList extends Bloc<EventPostList, StatePostList> {
  final PostApiClient client;

  BlocPostList({required this.client}) : super(StatePostList());

  @override
  Stream<Transition<EventPostList, StatePostList>> transformEvents(
    Stream<EventPostList> events,
    TransitionFunction<EventPostList, StatePostList> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<StatePostList> mapEventToState(EventPostList event) async* {
    if (event is EventPostListFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<StatePostList> _mapPostFetchedToState(StatePostList state) async {
    if (state.hasReachedMax) return state;

    try {
      if (state.status == PostStatus.initial) {
        Response<BuiltList<BuiltPost>> data = await client.getPosts();
        List<BuiltPost> postList = data.body?.toList() ?? [];
        return state.copyWith(
            status: PostStatus.success,
            posts: postList,
            hasReachedMax: postList.isEmpty);
      }

      Response<BuiltList<BuiltPost>> data =
          await client.getPosts(start: state.posts.length);
      List<BuiltPost> postList = data.body?.toList() ?? [];

      return state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(postList),
          hasReachedMax: postList.isEmpty);
    } catch (e) {
      print(e);
      return state.copyWith(status: PostStatus.failure);
    }
  }

}
