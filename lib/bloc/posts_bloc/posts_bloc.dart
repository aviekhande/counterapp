import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:counterapp/repository/getposts_api/getposts_api_repository.dart';
import 'package:equatable/equatable.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>(_onfetchpost);
  }
  void _onfetchpost(PostsEvent event, Emitter<PostsState> emit)async {
    // emit();
    log("In On FetchPost");
    List posts= await GetPosts().getPostsData();
    emit(PostsLoaded(posts));
  }
}
