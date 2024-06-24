part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List posts;

  const PostsLoaded(this.posts);
}
