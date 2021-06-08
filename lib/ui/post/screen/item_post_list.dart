import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/postDetail/screen/post_detail_page.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key, required this.post}) : super(key: key);

  final BuiltPost post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostDetailPage(postId: post.id!)));
        },
        leading: Text('${post.id}', style: textTheme.caption),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
