import 'package:chopper_demo/model/built_post.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState {}

class HomeStateErrorOccurred extends HomeState {
  final String error;

  const HomeStateErrorOccurred(this.error);

  @override
  List<Object> get props => [error];
}

class HomeStateOpenPost extends HomeState {
  final int postId;

  const HomeStateOpenPost(this.postId);

  @override
  List<Object> get props => [postId];
}

class HomeStatePosting extends HomeState {}

class HomeStatePostPosted extends HomeState {
  final String msg;

  const HomeStatePostPosted(this.msg);

  @override
  List<Object?> get props => [msg];
}
