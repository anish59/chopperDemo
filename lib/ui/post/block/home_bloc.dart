import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/home_event.dart';
import 'package:chopper_demo/ui/post/block/home_state.dart';
import 'package:chopper_demo/util/logger.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlock extends Bloc<EventsHome, HomeState> {
  final PostApiService client;

  HomeBlock({required this.client}) : super(HomeStateLoading());

  @override
  HomeState get state => HomeStateLoading();

  @override
  Stream<HomeState> mapEventToState(EventsHome event) async* {
    try {
      if (event is EventHomeGetAllPost) {
        yield HomeStateLoading();

        Response<BuiltList<BuiltPost>> allPost = await client.getPosts();

        // safe accessing the value
        yield HomeStateGettingAllPost(allPost.body?.toList() ?? []);
      } else if (event is EventHomeOpenPostDetail) {
        yield HomeStateOpenPost(event.postId);
      }else if(event is EventHomePostThePost){
        yield HomeStatePosting();


        final response = await client.postPost(event.post);

        if(response.isSuccessful){
          log.info("successfully Posted : ${response.body.toString()}" );
          yield HomeStatePostPosted("successfully Posted");
        }else{
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
