part of 'posts_bloc.dart';

sealed class PostsState  {
 
}
 class PostsInitial extends PostsState {}
 class PostsFetch extends PostsState{
  List<Posts>? posts;
  PostsFetch({required this.posts});
 }
class LoadingState extends PostsState{
  bool isLoading;
  LoadingState({required this.isLoading});
}
class SearchState extends PostsState{}