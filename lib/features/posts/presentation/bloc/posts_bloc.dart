import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:counterapp/features/posts/data/data_source/getpost_api.dart';
import 'package:flutter/material.dart';
import '../../data/models/posts_model.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService1 apiService;
  List<Posts>? post;
  List<Posts>? searchPost;
  PostsBloc({required this.apiService}) : super(PostsInitial()) {
    on<PostsInitialEvent>(_initial);
    on<PostsLoading>(_getPosts);
    on<PostsSearch>(_searchPosts);
    on<LoadingMore>(_loadingMore);
  }
  void _loadingMore(LoadingMore event, Emitter<PostsState> emit) {}
  void _initial(PostsInitialEvent event, Emitter<PostsState> emit) async {
    post = [];
    emit(PostsInitial());
  }

  void _getPosts(PostsLoading event, Emitter<PostsState> emit) async {
    // emit(PostsInitial());
    log("${event.skip}");
    Posta posts = await apiService.getPostData(4, event.skip);
    if (post == null) {
      post = posts.posts;
    } else if (posts.posts != null) {
      post = post! + posts.posts!;
    }
    log("$post");
    emit(PostsFetch(posts: post));
  }

  bool isPresent(int? postId, int? id) {
    while (postId != 0) {
      int temp = postId! % 10;
      if (temp == id || postId == id) {
        log("$postId");
        return true;
      }
      postId = postId ~/ 10;
    }
    return false;
  }

  void _searchPosts(PostsSearch event, Emitter<PostsState> emit) async {
    // searchPost = post!
    //     .where(
    //       (item) => item
    //           .toString()
    //           .toLowerCase()
    //           .contains(event.id.toString().toLowerCase()),
    //     )
    //     .toList();
    for (int i = 0; i < post!.length; i++) {
      if (isPresent(post?[i].userId, event.id)) {
        searchPost = searchPost! + [post![i]];
      }
      // if (post?[i].userId == event.id) {
      //   searchPost = [post![i]];
      //   break;
      // }
    }
    if (searchPost!.isEmpty) {
      log("$post");
      ScaffoldMessenger.of(event.context!)
          .showSnackBar(const SnackBar(content: Text("User Id Not Found")));
      emit(PostsFetch(posts: post));
    }
    if (searchPost!.isNotEmpty) {
      log("$searchPost");
      emit(PostsFetch(posts: searchPost));
      searchPost = [];
    }
  }
}
