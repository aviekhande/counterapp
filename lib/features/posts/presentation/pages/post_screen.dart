import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/configs/components/appbar_widget.dart';
import 'package:counterapp/core/configs/components/drawer_widget.dart';
import 'package:counterapp/features/posts/presentation/widgets/postcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/posts_bloc.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLoadingMore = true;
  int page = 0;
  final scrollController = ScrollController();
  @override
  void initState() {
    context.read<PostsBloc>().add(PostsLoading(skip: 0));
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: const CommonAppBar(screenName: "Posts")),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isLoadingMore = state.isLoading;
            log("$isLoadingMore");
          }
        },
        builder: (context, state) {
          return state is PostsFetch
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: isLoadingMore
                      ? state.posts!.length + 1
                      : state.posts!.length,
                  itemBuilder: (context, index) {
                    log("IsLoading Change");
                    return index < state.posts!.length
                        ? Mycontainer(postData: state.posts![index])
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      drawer: const CommonDrawer(),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        isLoadingMore == true) {
      page = page + 1;
      context.read<PostsBloc>().add(LoadingMore(isLoadingMore: true));
      context.read<PostsBloc>().add(PostsLoading(skip: 10 * page));
      // context.read<PostsBloc>().add(LoadingMore(isLoadingMore: false));
    }
  }
}
