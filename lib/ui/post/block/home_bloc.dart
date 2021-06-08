import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/home_event.dart';
import 'package:chopper_demo/ui/post/block/home_state.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum PostStatus { Initial, Success }

class BlocHome extends Bloc<EventsHome, HomeState> {
  final PostApiClient client;

  PostStatus status = PostStatus.Initial;
  List<BuiltPost> postList = [];
  bool hasReachedMax = false;

  BlocHome({required this.client}) : super(HomeStateLoading());

  @override
  HomeState get state => HomeStateLoading();

  @override
  Stream<Transition<EventsHome, HomeState>> transformEvents(
      Stream<EventsHome> events,
      TransitionFunction<EventsHome, HomeState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(EventsHome event) async* {
    try {
      if (hasReachedMax)
        yield state;
      else if (event is EventHomeGetAllPost) {
        if (status == PostStatus.Initial) {
          yield HomeStateLoading();
          Response<BuiltList<BuiltPost>> data = await client.getPosts();
          postList = data.body?.toList() ?? [];
        } else if (status == PostStatus.Success) {
          Response<BuiltList<BuiltPost>> data =
              await client.getPosts(start: postList.length);

          postList.addAll(data.body?.toList() ?? []);
        }

        hasReachedMax = false;
        status = PostStatus.Success;

        yield HomeStateGettingAllPost(postList, hasReachedMax);
      } else if (event is EventHomeOpenPostDetail) {
        yield HomeStateOpenPost(event.postId);
      } else if (event is EventHomePostThePost) {
        yield HomeStatePosting();

        final response = await client.postPost(event.post);

        if (response.isSuccessful) {
          log.info("successfully Posted : ${response.body.toString()}");
          yield HomeStatePostPosted("successfully Posted");
        } else {
          yield HomeStateErrorOccurred('failed to post');
        }
      }
    } catch (e) {
      print(e);
      log.severe("HomeBlockError: ${e.toString()}");
      yield HomeStateErrorOccurred(e.toString());
    }
  }
}
