// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'built_job.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltJob> _$builtJobSerializer = new _$BuiltJobSerializer();

class _$BuiltJobSerializer implements StructuredSerializer<BuiltJob> {
  @override
  final Iterable<Type> types = const [BuiltJob, _$BuiltJob];
  @override
  final String wireName = 'BuiltJob';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltJob object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  BuiltJob deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new BuiltJobBuilder().build();
  }
}

class _$BuiltJob extends BuiltJob {
  factory _$BuiltJob([void Function(BuiltJobBuilder)? updates]) =>
      (new BuiltJobBuilder()..update(updates)).build();

  _$BuiltJob._() : super._();

  @override
  BuiltJob rebuild(void Function(BuiltJobBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltJobBuilder toBuilder() => new BuiltJobBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltJob;
  }

  @override
  int get hashCode {
    return 935950441;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('BuiltJob').toString();
  }
}

class BuiltJobBuilder implements Builder<BuiltJob, BuiltJobBuilder> {
  _$BuiltJob? _$v;

  BuiltJobBuilder();

  @override
  void replace(BuiltJob other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltJob;
  }

  @override
  void update(void Function(BuiltJobBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltJob build() {
    final _$result = _$v ?? new _$BuiltJob._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
