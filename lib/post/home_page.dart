import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/post/post_detail.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:built_collection/built_collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Demo'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final response =
              await Provider.of<PostApiService>(context, listen: false)
                  .postPost(BuiltPost((b) => b
                    ..title = 'new Title'
                    ..body = 'new body text blah blah'));

          if (response.isSuccessful) {
            print('success ${response.body}');
          } else {
            print('RC => ${response.statusCode}');
            print('error add post: ${response.error}');
          }
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response<BuiltList<BuiltPost>>>(
      future: Provider.of<PostApiService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.statusCode != 200) {
            String error= snapshot.error.toString() ?? 'Error occurred';
            return Center(child: Text(error));
          } else {
            final BuiltList<BuiltPost> posts = snapshot.data!.body!;
            return _buildPostList(context, posts);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

ListView _buildPostList(BuildContext context, BuiltList<BuiltPost> posts) {
  return ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            posts[index].title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[index].body),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PostDetailPage(postId: posts[index].id!)))
          },
        ),
      );
    },
  );
}
