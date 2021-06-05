import 'package:chopper_demo/model/built_post.dart';
import 'package:equatable/equatable.dart';

abstract class EventsHome extends Equatable {
  const EventsHome();

  @override
  List<Object> get props => [];
}

class EventHomeGetAllPost extends EventsHome {}

class EventHomeOpenPostDetail extends EventsHome {
  final int postId;

  EventHomeOpenPostDetail(this.postId);
}

class EventHomePostThePost extends EventsHome {
  final BuiltPost post;

  EventHomePostThePost(this.post);

  @override
  List<Object> get props => [post];
}
