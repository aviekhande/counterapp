import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:counterapp/core/theme/app_theme.dart';
import 'package:counterapp/core/theme/bloc/theme_bloc_bloc.dart';
import 'package:counterapp/features/profile_details/presentation/bloc/bloc/profiledata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

DocumentSnapshot? docSnap;

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<ProfiledataBloc>().add(ProfileInfoFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfiledataBloc, ProfiledataState>(
        builder: (context, state) {
      return Drawer(
        width: 295.w,
        backgroundColor: Theme.of(context).colorScheme.surface,
        //  const Color.fromARGB(255, 227, 234, 245),
        child: state is ProfileDataLoading
            ? Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context)
                          .popAndPush(const ProfileScreenRoute());
                    },
                    child: CircleAvatar(
                      radius: 40.w,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      //  const Color.fromARGB(255, 227, 234, 245),
                      child: state.docSnap?['image'].isEmpty
                          ? SvgPicture.asset(
                              "assets/images/Isolation_Mode.svg",
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: "assets/images/grey-9026.gif",
                              image: state.docSnap?['image'],
                              placeholderCacheHeight: 5,
                              placeholderCacheWidth: 5,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${state.docSnap?['name']}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${state.docSnap?['email']}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Theme :",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Container(
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface ==
                                        Colors.grey.shade200
                                    ? Colors.blue[200]
                                    : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<ThemeBlocBloc>().add(
                                        ThemeBlocEvent(themeData: lightMode));
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Colors.grey.shade200
                                            ? Colors.white
                                            : Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.7.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<ThemeBlocBloc>().add(
                                        ThemeBlocEvent(themeData: darkMode));
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface !=
                                                Colors.grey.shade200
                                            ? Colors.white
                                            : Colors.blue[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
