import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventGetAllPost extends HomeEvent {}

class HomeEventOpenPostDetail extends HomeEvent {
  final int postId;

  HomeEventOpenPostDetail(this.postId);
}
