import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/home_bloc.dart';
import 'package:chopper_demo/ui/post/block/home_event.dart';
import 'package:chopper_demo/ui/post/block/home_state.dart';
import 'package:chopper_demo/ui/postDetail/screen/post_detail_page.dart';
import 'package:chopper_demo/ui_components/bottom_loader.dart';
import 'package:chopper_demo/ui_components/loader_dialog.dart';
import 'package:chopper_demo/ui_components/snackbar.dart';
import 'package:chopper_demo/webService/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BlocHome homeBloc;
  AlertDialog? dialog;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<BlocHome>(context);
    homeBloc.add(EventHomeGetAllPost());
    _scrollController.addListener(_onScroll);
  }

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
          BuiltPost post = BuiltPost((b) => b
            ..title = 'new Title'
            ..body = 'new body text blah blah');

          homeBloc.add(EventHomePostThePost(post));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    /* return BlocBuilder<HomeBlock,HomeState>(builder: (context,state){
      Center(child: CircularProgressIndicator());
    },);*/

/*    return BlocBuilder(builder: (context,state){
      return Center(child: CircularProgressIndicator());
    });*/

    return BlocConsumer<BlocHome, HomeState>(
      builder: (context, state) {
        if (state is HomeStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeStateGettingAllPost) {
          return _buildPostList(state, context);
        } else if (state is HomeStatePostPosted) {
          return Center(child: CircularProgressIndicator()); // after posting
          // we need to load the data again that why progress indicator
        } else {
          return Scaffold(body: Center(child: Text("Proper state not found")));
        }
      },
      listener: (context, state) {
        if (state is HomeStateOpenPost) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostDetailPage(
                    postId: state.postId,
                  )));

          // as we click on item and state is changed to HomeStateOpenPost
          // which we should not change the state at first place as it can go
          // directly on item press, so this condition could have been skipped
          // but for understanding we have to implement this if condition block
          // that's y calling back the api again

          homeBloc.add(EventHomeGetAllPost());

          // and one more thing set this kind of state only when you don't
          // have to come back again and reloading the item is not needed

        } else if (state is HomeStatePosting) {
          dialog = showLoaderDialog(context);
        } else if (state is HomeStatePostPosted) {
          if (dialog != null) {
            Navigator.pop(context); // check from here
          }

          showSnackBar(context, msg: 'your Post is successfully posted');

          homeBloc.add(EventHomeGetAllPost());
        }
      },
    );

    /* return FutureBuilder<Response<BuiltList<BuiltPost>>>(
      future: Provider.of<PostApiService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.statusCode != 200) {
            String error = snapshot.error.toString();
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
  }*/
  }

  ListView _buildPostList(HomeStateGettingAllPost state, BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount:
          state.hasReachedMax ? state.posts.length : state.posts.length + 1,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return index >= state.posts.length
            ? BottomLoader()
            : _buildCardPostItem(state.posts, index);
      },
    );
  }

  Card _buildCardPostItem(List<BuiltPost> posts, int index) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(
          '$index ${posts[index].title}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(posts[index].body),
        onTap: () => {
          /*
            you can add this navigator directly but for practice add event
            over here instead
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PostDetailPage(postId: posts[index].id!)))
                */
          homeBloc.add(EventHomeOpenPostDetail(posts[index].id ?? 0))
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) homeBloc.add(EventHomeGetAllPost());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
