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
  bool isLoadingMore = false;
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
          preferredSize: Size.fromHeight(75.h),
          child: const CommonAppBar(screenName: "Posts")),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return state is PostsFetch
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: isLoadingMore
                      ? state.posts!.length
                      : state.posts!.length + 1,
                  itemBuilder: (context, index) {
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

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      setState(() {
        isLoadingMore = true;
      });
      context.read<PostsBloc>().add(PostsLoading(skip: 10 * page));
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}