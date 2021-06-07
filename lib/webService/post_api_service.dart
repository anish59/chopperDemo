import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper_demo/constant/strings.dart';
import 'package:chopper_demo/errorHandling/response_failure.dart';
import 'package:chopper_demo/interceptors_converters/built_value_converter.dart';
import 'package:chopper_demo/interceptors_converters/network_interceptor.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/webService/app_config.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class PostApiClient extends ChopperService {
  @Get(path: AppApis.getAllPost)
  Future<Response<BuiltList<BuiltPost>>> getPosts(
      {@Query('_start') int start = 0, @Query('_limit') int limit = 6});

  @Get(path: AppApis.getPostDetail)
  Future<Response<BuiltPost>> getPost(
    @Path('id') id,
  );

  @Post(path: AppApis.postPost)
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost post,
  );

  static PostApiClient create() {
    final client = ChopperClient(
      baseUrl: AppConfig.getInstance().apiBaseUrl,
      services: [
        _$PostApiClient(),
      ],
      converter: BuiltValueConverter(),
      errorConverter: BuiltValueConverter(errorType: ResponseFailure),
      interceptors: [
        // Both request & response interceptors go here
        HttpLoggingInterceptor(),
        NetworkInterceptor(),
      ],
    );

    return _$PostApiClient(client);
  }
}
