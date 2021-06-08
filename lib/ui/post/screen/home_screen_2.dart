import 'package:chopper_demo/di/injection_container.dart';
import 'package:chopper_demo/model/built_post.dart';
import 'package:chopper_demo/ui/post/block/bloc_post_list.dart';
import 'package:chopper_demo/ui/post/block/event_post_list.dart';
import 'package:chopper_demo/ui/post/block/home_bloc.dart';
import 'package:chopper_demo/ui/post/block/index_home.dart';
import 'package:chopper_demo/ui_components/loader_dialog.dart';
import 'package:chopper_demo/ui_components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'List_posts.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late BlocHome homeBloc;
  AlertDialog? dialog;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<BlocHome>(context);
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
    return BlocConsumer<BlocHome, HomeState>(
      buildWhen: (previousState, currentState) {
        print(
            "Call buildWhen(previous: $previousState, current: $currentState)");
        return currentState is HomeStateInitial;
      },
      builder: (context, state) {
        if (state is HomeStateInitial) {
          // it will build only when
          // currentState is  HomeStateInitial
          return BlocProvider<BlocPostList>(
            create: (context) => serviceLocator<BlocPostList>()..add(EventPostListFetched()),
            child: ListPost(),
          );
        } else {
          return Scaffold(body: Center(child: Text("Proper state not found")));
        }
      },
      listener: (context, state) {
        if (state is HomeStatePosting) {
          dialog = showLoaderDialog(context);
        } else if (state is HomeStatePostPosted) {
          if (dialog != null) {
            Navigator.pop(context); // check from here
          }

          showSnackBar(context, msg: 'your Post is successfully posted');
        } else if (state is HomeStateErrorOccurred) {
          showSnackBar(context, msg: state.error);
        }
      },
    );
  }
}
