import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:counterapp/features/posts/data/data_source/getpost_api.dart';
import '../../data/models/posts_model.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService1 apiService;
  List<Posts>? post;
  PostsBloc({required this.apiService}) : super(PostsInitial()) {
    on<PostsLoading>(_getPosts);
  }
  void _getPosts(PostsLoading event, Emitter<PostsState> emit) async {
    log("${event.skip}");
    Posta posts = await apiService.getPostData(10, event.skip);
    if(post == null) {
        post =posts.posts;
    }else
    if(posts.posts != null){
        post = post! + posts.posts!;
    }
    
    log("$post");
    emit(PostsFetch(posts: post));
  }
}
