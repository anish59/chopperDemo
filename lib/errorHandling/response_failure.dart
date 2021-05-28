import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'response_failure.g.dart';


abstract class ResponseFailure implements Built<ResponseFailure, ResponseFailureBuilder> {
  ResponseFailure._();
  factory ResponseFailure([void Function(ResponseFailureBuilder) updates]) = _$ResponseFailure;
  static Serializer<ResponseFailure> get serializer
  =>_$responseFailureSerializer;
}