import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/common/bloc/appbar_bloc.dart';
import 'package:counterapp/core/configs/components/debouncing.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:counterapp/features/auth/domain/usecases/authentication.dart';
import 'package:counterapp/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatefulWidget {
  final String screenName;
  final bool isProfile;
  const CommonAppBar(
      {super.key, required this.screenName, this.isProfile = false});
  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  TextEditingController searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);
  Timer? _debounce;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    searchController.addListener(_sendrequest);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _sendrequest() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds:00), () {
      if (this.searchText != searchController.text) {
        context.read<PostsBloc>().add(PostsSearch(
            skip: 0, id: int.parse(searchController.text), context: context));
      }
    });
    // log("In send request: ");
    // _debouncer.run(() {
    //   context
    //       .read<PostsBloc>()
    //       .add(PostsSearch(skip: 0, id: int.parse(value), context: context));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          widget.isProfile
              ? GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).popForced();
                  },
                  child:
                      const Icon(Icons.arrow_back_rounded, color: Colors.white),
                )
              : GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(Icons.menu_sharp, color: Colors.white),
                ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.screenName == "Posts"
                  ? SizedBox(
                      height: 42.h,
                    )
                  : SizedBox(
                      height: 25.h,
                    ),
              Text(
                widget.screenName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.h,
              ),
              widget.screenName == "Posts"
                  ? Row(
                      children: [
                        Container(
                          // padding: EdgeInsets.all(5),
                          height: 40,
                          width: 270.w,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 220.w,
                                child: BlocConsumer<AppbarBloc, AppbarState>(
                                  listener: (context, state) {
                                    if (state is AppbarInitial) {
                                      searchController.clear();
                                    }
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      keyboardType: TextInputType.number,
                                      // onFieldSubmitted: _sendrequest,
                                      // onChanged: _sendrequest,
                                      controller: searchController,
                                      cursorRadius: const Radius.circular(100),
                                      cursorHeight: 20,
                                      decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                          contentPadding: EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          hintText: "search user id...",
                                          border: InputBorder.none),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _sendrequest();
                                  },
                                  icon: const Icon(Icons.search))
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<PostsBloc>()
                                  .add(PostsInitialEvent());
                              context
                                  .read<PostsBloc>()
                                  .add(PostsLoading(skip: 0));
                              context.read<AppbarBloc>().add(clearSearch());
                            },
                            icon: const Icon(
                                Icons.settings_backup_restore_outlined))
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 0.h,
              )
            ],
          ),
        ],
      ),
      actions: [
        widget.isProfile
            ? GestureDetector(
                onTap: () {
                  AuthMethod().signOut();
                  AutoRouter.of(context).replaceAll([const LoginScreenRoute()]);
                },
                child: const Icon(Icons.logout_outlined, color: Colors.white),
              )
            : const SizedBox(),
        SizedBox(
          width: 20.w,
        )
      ],
      backgroundColor: const Color.fromARGB(255, 114, 182, 214),
    );
  }
}

Widget app() {
  return AppBar();
}
