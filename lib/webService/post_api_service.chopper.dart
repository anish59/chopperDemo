// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PostApiClient extends PostApiClient {
  _$PostApiClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiClient;

  @override
  Future<Response<BuiltList<BuiltPost>>> getPosts(
      {int start = 0, int limit = 6}) {
    final $url = '/posts';
    final $params = <String, dynamic>{'_start': start, '_limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<BuiltList<BuiltPost>, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> getPost(dynamic id) {
    final $url = '/posts/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> postPost(BuiltPost post) {
    final $url = '/posts';
    final $body = post;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<BuiltPost, BuiltPost>($request);
  }
}
