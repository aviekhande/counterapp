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
  PostsBloc({required this.apiService}) : super(PostsInitial()) {
    on<PostsInitialEvent>(_initial);
    on<PostsLoading>(_getPosts);
    on<PostsSearch>(_searchPosts);
  }

  void _initial(PostsInitialEvent event, Emitter<PostsState> emit) async {
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

  void _searchPosts(PostsSearch event, Emitter<PostsState> emit) async {
    for (int i = 0; i < post!.length; i++) {
      if (post?[i].userId == event.id) {
        post = [post![i]];
        break;
      }
      if (post!.length - 1 == i) {
        ScaffoldMessenger.of(event.context!)
            .showSnackBar(const SnackBar(content: Text("No User Found")));
      }
    }
    if (post != null) {
      emit(PostsFetch(posts: post));
      post = [];
    }
  }
}
