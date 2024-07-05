import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/configs/routes/routes_import.gr.dart';
import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:flutter/material.dart';
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
    getUserData();
  }

  String imageUrl = "";
  // DocumentSnapshot? docSnap;
  Future<DocumentSnapshot?> getUserData() async {
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(SessionController().userId)
    //     .get()
    //     .then((value) {
    //   docSnap = value;
    // });
    await FirebaseFirestore.instance
        .collection("profile")
        .doc(SessionController().userId)
        .get()
        .then((value) {
      docSnap = value;
    });
    imageUrl = docSnap?['image'];
    setState(() {});
    //  User user =U?ser.fromJson(!docSnap);
    return docSnap;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 295.w,
      backgroundColor: const Color.fromARGB(255, 227, 234, 245),
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(const ProfileScreenRoute());
            },
            child: CircleAvatar(
              radius: 40.w,
              backgroundColor: const Color.fromARGB(255, 227, 234, 245),
              child: imageUrl.isEmpty
                  ? SvgPicture.asset(
                      "assets/images/Isolation_Mode.svg",
                    )
                  : Image.network(imageUrl),
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
      ),
    );
  }
}
