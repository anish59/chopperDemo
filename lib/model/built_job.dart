import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'built_job.g.dart';


abstract class BuiltJob implements Built<BuiltJob, BuiltJobBuilder> {
  BuiltJob._();
  factory BuiltJob([void Function(BuiltJobBuilder) updates]) = _$BuiltJob;
  static Serializer<BuiltJob> get serializer =>_$builtJobSerializer;
}