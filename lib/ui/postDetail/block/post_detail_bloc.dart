import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_event.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_state.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockPostDetail extends Bloc<EventPostDetail, StatePostDetail> {
  final PostApiService service;

  BlockPostDetail({required this.service}) : super(StatePDLoadingPost());

  @override
  Stream<StatePostDetail> mapEventToState(EventPostDetail event) async* {
    try {
      if (event is EventPDGetPostDetail) {
        yield StatePDLoadingPost();

        Response<BuiltPost> postDetail =
            await service.getPost(event.postDetailId);

        // safe accessing the value
        yield StatePDDataLoaded(postDetail.body ?? BuiltPost());
      }
    } catch (e) {
      print(e);
      yield StatePDError(e.toString());
    }
  }
}
