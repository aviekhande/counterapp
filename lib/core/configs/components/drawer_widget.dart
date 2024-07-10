import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
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
        backgroundColor: const Color.fromARGB(255, 227, 234, 245),
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
                      backgroundColor: const Color.fromARGB(255, 227, 234, 245),
                      child: state.docSnap?['image'].isEmpty
                          ? SvgPicture.asset(
                              "assets/images/Isolation_Mode.svg",
                            )
                          : Image.network(state.docSnap?['image']),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "${docSnap?['name']}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${docSnap?['email']}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
