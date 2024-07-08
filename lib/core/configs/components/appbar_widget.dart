import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:counterapp/features/auth/domain/usecases/authentication.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
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
          Text(
            widget.screenName,
            style: const TextStyle(color: Colors.white),
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
