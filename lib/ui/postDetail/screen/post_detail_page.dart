import 'package:chopper_demo/di/injection_container.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_bloc.dart';
import 'package:chopper_demo/ui/postDetail/screen/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<BlocPostDetail>(
        create: (context) => serviceLocator<BlocPostDetail>(),
        child: PostDetailScreen(
          postId: postId,
        ),
      );
}
