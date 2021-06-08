
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:equatable/equatable.dart';

part 'built_post.g.dart';

abstract class BuiltPost extends Equatable implements Built<BuiltPost,
    BuiltPostBuilder>{

  int? get id;

  String get title;
  String get body;

  BuiltPost._();

  factory BuiltPost([updates(BuiltPostBuilder b)]) = _$BuiltPost;

  static Serializer<BuiltPost> get serializer => _$builtPostSerializer;

  @override
  List<Object?> get props => [id,title,body];

}