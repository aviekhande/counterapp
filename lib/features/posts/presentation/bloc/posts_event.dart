part of 'posts_bloc.dart';

sealed class PostsEvent {
}
class PostsLoading extends PostsEvent {
  int skip;
  PostsLoading({required this.skip});
}
