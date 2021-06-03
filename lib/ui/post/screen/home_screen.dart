import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/home_block.dart';
import 'package:chopper_demo/ui/post/block/home_event.dart';
import 'package:chopper_demo/ui/post/block/home_state.dart';
import 'package:chopper_demo/ui/postDetail/post_detail.dart';
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
  late HomeBlock homeBlock;

  @override
  void initState() {
    super.initState();
    homeBlock = BlocProvider.of<HomeBlock>(context);
    homeBlock.add(HomeEventGetAllPost());
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

  Widget _buildBody(BuildContext context) {
    /* return BlocBuilder<HomeBlock,HomeState>(builder: (context,state){
      Center(child: CircularProgressIndicator());
    },);*/

/*    return BlocBuilder(builder: (context,state){
      return Center(child: CircularProgressIndicator());
    });*/

    return BlocConsumer<HomeBlock, HomeState>(
      builder: (context, state) {
        if (state is HomeStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeStateGettingAllPost) {
          return _buildPostList(context, state.allPost);
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

          homeBlock.add(HomeEventGetAllPost());

          // and one more thing set this kind of state only when you don't
          // have to come back again and reloading the item is not needed

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

  ListView _buildPostList(BuildContext context, List<BuiltPost> posts) {
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
              /*
              you can add this navigator directly but for practice add event
              over here instead
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PostDetailPage(postId: posts[index].id!)))
                  */
              homeBlock.add(HomeEventOpenPostDetail(posts[index].id ?? 0))
            },
          ),
        );
      },
    );
  }
}
