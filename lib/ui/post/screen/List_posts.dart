import 'package:chopper_demo/ui/post/block/bloc_post_list.dart';
import 'package:chopper_demo/ui/post/block/event_post_list.dart';
import 'package:chopper_demo/ui/post/block/state_post_list.dart';
import 'package:chopper_demo/ui_components/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_post_list.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key? key}) : super(key: key);

  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  final _scrollController = ScrollController();
  late BlocPostList _blocPostList;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _blocPostList = BlocProvider.of<BlocPostList>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPostList,StatePostList>(builder: (context,state){
      switch (state.status){
        case PostStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case PostStatus.success:
          if (state.posts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostList(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  void _onScroll() {
    if (_isBottom) _blocPostList.add(EventPostListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

}
