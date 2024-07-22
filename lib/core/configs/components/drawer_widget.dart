import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/core/common/drawerbloc/startup_bloc.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:counterapp/core/theme/app_theme.dart';
import 'package:counterapp/core/theme/bloc/theme_bloc_bloc.dart';
import 'package:counterapp/features/profile_details/presentation/bloc/bloc/profiledata_bloc.dart';
import 'package:counterapp/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/localizationbloc/locbloc_bloc.dart';

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
                  BlocBuilder<LocBloc, LocState>(
                    builder: (context, state) {
                      final Locale currentLocale =
                          state is ChangeState ? state.loc : const Locale('en');
                      return BlocBuilder<StartupBloc, StartupState>(
                        builder: (context, state) {
                          final bool isDisplayTheme = state is StartupCheck
                              ? state.displaySwitch
                              : true;
                          log("$isDisplayTheme");
                          final bool isDisplayLang = state is StartupCheck
                              ? state.displayLanguage
                              : true;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 300.w,
                              ),
                              isDisplayTheme
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text(
                                          "${AppLocalizations.of(context)!.themeName} :",
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 7.w,
                                        ),
                                        Container(
                                          height: 18.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                          .colorScheme
                                                          .surface ==
                                                      Colors.grey.shade200
                                                  ? Colors.blue[200]
                                                  : Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                                  context
                                                      .read<ThemeBlocBloc>()
                                                      .add(ThemeBlocEvent(
                                                          themeData:
                                                              lightMode));
                                                },
                                                child: Container(
                                                  height: 18.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .surface ==
                                                              Colors
                                                                  .grey.shade200
                                                          ? Colors.white
                                                          : Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.7.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<ThemeBlocBloc>()
                                                      .add(ThemeBlocEvent(
                                                          themeData: darkMode));
                                                },
                                                child: Container(
                                                  height: 18.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .surface !=
                                                              Colors
                                                                  .grey.shade200
                                                          ? Colors.white
                                                          : Colors.blue[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: 15.h,
                              ),
                              isDisplayLang
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            "${AppLocalizations.of(context)!.lang} :",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                // color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<LocBloc>(context)
                                                .add(ChangeLang(
                                                    loc: const Locale('en')));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 36.w),
                                            color: Colors.transparent,
                                            child: Text(
                                              'English',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: currentLocale ==
                                                        const Locale("en")
                                                    ? Colors.blue
                                                    : Theme.of(context)
                                                                .colorScheme
                                                                .surface !=
                                                            Colors.grey.shade900
                                                        ? Colors.black
                                                        : Colors.white,
                                                fontWeight: currentLocale ==
                                                        const Locale("en")
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<LocBloc>(context)
                                                .add(ChangeLang(
                                                    loc: const Locale('hi')));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 36.0.w),
                                            color: Colors.transparent,
                                            child: Text(
                                              'हिंदी',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: currentLocale ==
                                                        const Locale("hi")
                                                    ? Colors.blue
                                                    : Theme.of(context)
                                                                .colorScheme
                                                                .surface !=
                                                            Colors.grey.shade900
                                                        ? Colors.black
                                                        : Colors.white,
                                                fontWeight: currentLocale ==
                                                        const Locale("hi")
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
