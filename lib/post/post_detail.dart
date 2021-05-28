import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post detail'),
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response<BuiltPost>>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (_, AsyncSnapshot<Response<BuiltPost>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.statusCode != 200) {
              String error = snapshot.error.toString() ?? 'Error occurred';
              return Center(child: Text(error));
            } else {
              final Map posts = json.decode(snapshot.data!.bodyString);
              return _buildPostDetail(posts);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}

Center _buildPostDetail(Map post) {
  return Center(
    child: Card(
      child: Column(
        children: [
          Text(
            post['title'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(post['body']),
        ],
      ),
    ),
  );
}
