

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'built_job.dart';
import 'built_post.dart';

part 'serializers.g.dart';

@SerializersFor(const [BuiltPost,BuiltJob])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();