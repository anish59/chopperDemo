import 'package:chopper_demo/model/built_post.dart';
import 'package:equatable/equatable.dart';

abstract class StatePostDetail extends Equatable {
  @override
  List<Object> get props => [];
}

class StatePDLoadingPost extends StatePostDetail {}

class StatePDDataLoaded extends StatePostDetail {
  final BuiltPost post;

  StatePDDataLoaded(this.post);

  @override
  List<Object> get props => [post];
}
class StatePDError extends StatePostDetail {
  final String error;

  StatePDError(this.error);

  @override
  List<Object> get props => [error];
}