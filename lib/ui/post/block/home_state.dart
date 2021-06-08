import 'package:chopper_demo/model/built_post.dart';
import 'package:equatable/equatable.dart';


abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateLoading extends HomeState {}

class HomeStateGettingAllPost extends HomeState {
  final List<BuiltPost> posts;
  final bool hasReachedMax;

  HomeStateGettingAllPost(this.posts, this.hasReachedMax);

  @override
  List<Object?> get props => [posts,hasReachedMax];

}

class HomeStateErrorOccurred extends HomeState {
  final String error;

  HomeStateErrorOccurred(this.error);

  @override
  List<Object> get props => [error];
}

class HomeStateOpenPost extends HomeState {
  final int postId;

  HomeStateOpenPost(this.postId);

  @override
  List<Object> get props => [postId];
}

class HomeStatePosting extends HomeState {}

class HomeStatePostPosted extends HomeState {
  final String msg;

  HomeStatePostPosted(this.msg);
  @override
  List<Object?> get props => [msg];
}
