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

  BlocHome({required this.client}) : super(HomeStateInitial());

/*  @override
  HomeState get state => HomeStateLoading();*/

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
      if (event is EventHomePostThePost) {
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
