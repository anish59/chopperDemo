class AppStrings {
  static _ServerURLs serverURLs = _ServerURLs();
  static _MockAssets mockAssets = _MockAssets();
  static _Channel channel = _Channel();
  static _ChannelMethod channelMethod = _ChannelMethod();
}

class _ServerURLs {
  final String dev = "https://jsonplaceholder.typicode.com";
  final String production = "https://jsonplaceholder.typicode.com";
// for mock flavor we generate http local client base url through code itself
}

class _MockAssets {
  final String kGetAllPost = 'assets/mock/get_all_post.json';
  final String kPostDetail = 'assets/mock/get_post.json';
  final String kErrorResponse = 'assets/mock/failure.json';
}

enum AppFlavors { dev, mock, production }

class _Channel {
  final String kApp = 'app';
}

class _ChannelMethod {
  final String kFlavor = "getFlavor";
  final String kDeviceId = "getDeviceID";
}

class AppApis {
  static const String getAllPost = "/posts";
  static const String getPostDetail = "/posts/{id}";
  static const String postPost = '/posts';
}
