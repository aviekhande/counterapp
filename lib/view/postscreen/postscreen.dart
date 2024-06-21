import 'package:counterapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:counterapp/view/postscreen/widget/postcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    PostsBloc().add(const PostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  "Posts",
                  style: TextStyle(color: Colors.white),
                )),
            body: BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PostsInitial:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case PostsLoaded:
                    final sucessState = state as PostsLoaded;
                    return ListView.builder(
                        itemCount: sucessState.posts.length,
                        itemBuilder: (context, index) {
                          return MycontainerState(
                              postsData: sucessState.posts[index]);
                        });
                  default:
                    return const SizedBox();
                }
              },
            ));
      },
    );
  }
}
