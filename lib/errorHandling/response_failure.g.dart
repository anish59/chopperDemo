// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_failure.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ResponseFailure> _$responseFailureSerializer =
    new _$ResponseFailureSerializer();

class _$ResponseFailureSerializer
    implements StructuredSerializer<ResponseFailure> {
  @override
  final Iterable<Type> types = const [ResponseFailure, _$ResponseFailure];
  @override
  final String wireName = 'ResponseFailure';

  @override
  Iterable<Object?> serialize(Serializers serializers, ResponseFailure object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  ResponseFailure deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new ResponseFailureBuilder().build();
  }
}

class _$ResponseFailure extends ResponseFailure {
  factory _$ResponseFailure([void Function(ResponseFailureBuilder)? updates]) =>
      (new ResponseFailureBuilder()..update(updates)).build();

  _$ResponseFailure._() : super._();

  @override
  ResponseFailure rebuild(void Function(ResponseFailureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResponseFailureBuilder toBuilder() =>
      new ResponseFailureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResponseFailure;
  }

  @override
  int get hashCode {
    return 153742374;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ResponseFailure').toString();
  }
}

class ResponseFailureBuilder
    implements Builder<ResponseFailure, ResponseFailureBuilder> {
  _$ResponseFailure? _$v;

  ResponseFailureBuilder();

  @override
  void replace(ResponseFailure other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResponseFailure;
  }

  @override
  void update(void Function(ResponseFailureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ResponseFailure build() {
    final _$result = _$v ?? new _$ResponseFailure._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
