import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_bloc.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_event.dart';
import 'package:chopper_demo/ui/postDetail/block/post_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late BlocPostDetail _blockPostDetail;

  @override
  void initState() {
    super.initState();
    _blockPostDetail = BlocProvider.of<BlocPostDetail>(context);
    _blockPostDetail.add(EventPDGetPostDetail(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post detail'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<BlocPostDetail, StatePostDetail>(
        builder: (context, state) {
      if (state is StatePDLoadingPost) {
        return Center(child: CircularProgressIndicator());
      } else if (state is StatePDDataLoaded) {
        return _buildPostDetail(state.post);
      } else if (state is StatePDError) {
        return Scaffold(body: Center(child: Text(state.error)));
      } else {
        return Scaffold(body: Center(child: Text("Proper state not found")));
      }
    });

    // return Center();
  }

  Center _buildPostDetail(BuiltPost post) {
    return Center(
      child: Card(
        child: Column(
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(post.body),
          ],
        ),
      ),
    );
  }
}
