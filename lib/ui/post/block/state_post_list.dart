import 'package:chopper_demo/model/built_post.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { initial, success, failure }

class StatePostList extends Equatable {
  final PostStatus status;
  final List<BuiltPost> posts;
  final bool hasReachedMax;

  StatePostList(
      {
      this.status = PostStatus.initial,
      this.posts = const <BuiltPost>[],
      this.hasReachedMax = false,
      });

  StatePostList copyWith({
    PostStatus? status,
    List<BuiltPost>? posts,
    bool? hasReachedMax,
  }){
    return StatePostList(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '{status : $status, posts : $posts, hasReachedMax : '
        '$hasReachedMax, listLength: ${posts.length}}';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
