import 'package:equatable/equatable.dart';

abstract class EventPostDetail extends Equatable{
  @override
  List<Object?> get props => [];

}

class EventPDGetPostDetail extends EventPostDetail{

  final int postDetailId;

  EventPDGetPostDetail(this.postDetailId);

  @override
  List<Object?> get props => [postDetailId];
}