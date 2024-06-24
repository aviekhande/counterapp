import 'package:bloc/bloc.dart';
import 'package:counterapp/model/getpost_model/getpost_model.dart';
import 'package:counterapp/repository/getposts_api/getposts_api_repository.dart';
import 'package:equatable/equatable.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>(_onfetchpost);
  }
  void _onfetchpost(PostsEvent event, Emitter<PostsState> emit)async {
    emit(PostsLoading());
    Map posts= await GetPosts().getPostsData();
    List<Posts> posts1=[];
    emit(PostsLoading());
    for(int i=0;i<posts["posts"].length;i++){
      posts1.add(Posts.fromJson(posts["posts"][i]));
    }
    emit(PostsLoaded(posts1));
  }
}
