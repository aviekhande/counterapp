part of 'posts_bloc.dart';

sealed class PostsEvent {}

class PostsInitialEvent extends PostsEvent {}

class PostsLoading extends PostsEvent {
  int skip;
  PostsLoading({required this.skip});
}

class PostsSearch extends PostsEvent {
  int skip;
  int? id;
  BuildContext? context;
  PostsSearch({required this.skip, this.id, this.context});
}
