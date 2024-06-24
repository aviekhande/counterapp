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
    List<PostElement> posts1=[];
    emit(PostsLoading());
    for(int i=0;i<posts.length;i++){
      posts1.add(PostElement(posts, id: posts["posts"][i]["id"], title: posts["posts"][i]["title"], body: posts["posts"][i]["body"], tags:  posts["posts"][i]["tags"], reactions:  Reactions(likes: posts["posts"][i]["reactions"]["likes"], dislikes: posts["posts"][i]["reactions"]["dislikes"]), views:  posts["posts"][i]["views"], userId:  posts["posts"][i]["userId"]));
    }
    emit(PostsLoaded(posts1));
  }
}
