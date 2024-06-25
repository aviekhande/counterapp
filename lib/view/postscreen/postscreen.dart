import 'package:counterapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:counterapp/repository/getposts_api/getposts_api_repository.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Product",
              style: TextStyle(color: Colors.white),
            )),
        body: BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostsLoaded) {
              print("object");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("all Data Fetch")));
            }
          },
          builder: (context, state) {
            return FutureBuilder(
                future: GetPosts().getPostsData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final sucessState = state as PostsLoaded;
                    return ListView.builder(
                        itemCount: sucessState.posts.length,
                        itemBuilder: (context, index) {
                          return MycontainerState(
                              postsData: sucessState.posts[index]);
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
            // switch (state.runtimeType) {
            //   case const (PostsInitial):
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   case const (PostsLoaded):
            //     final sucessState = state as PostsLoaded;
            //     return ListView.builder(
            //         itemCount: sucessState.posts.length,
            //         itemBuilder: (context, index) {
            //           return MycontainerState(
            //               postsData: sucessState.posts[index]);
            //         });
            //   default:
            //     return const SizedBox();
            // }
          },
        ));
  }
}
