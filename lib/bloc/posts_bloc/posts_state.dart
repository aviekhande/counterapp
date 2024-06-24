part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  
  @override
  List get props => [];
}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<PostElement> posts;

  const PostsLoaded(this.posts);
}
