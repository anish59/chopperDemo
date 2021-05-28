import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper_demo/errorHandling/response_failure.dart';
import 'package:chopper_demo/interceptors_converters/built_value_converter.dart';
import 'package:chopper_demo/interceptors_converters/network_interceptor.dart';
import 'package:chopper_demo/model/built_post.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class PostApiService extends ChopperService {
  @Get(path: "/posts")
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: "/posts/{id}")
  Future<Response<BuiltPost>> getPost(
    @Path('id') id,
  );

  @Post(path: '/posts')
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost post,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConverter(),
      errorConverter: BuiltValueConverter(errorType: ResponseFailure),
      interceptors: [
        // Both request & response interceptors go here
        HttpLoggingInterceptor(),
        NetworkInterceptor(),
      ],
    );

    return _$PostApiService(client);
  }
}
