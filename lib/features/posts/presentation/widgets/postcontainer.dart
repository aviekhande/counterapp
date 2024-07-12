import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/posts_model.dart';

class Mycontainer extends StatefulWidget {
  final Posts postData;
  const Mycontainer({super.key, required this.postData});

  @override
  State<Mycontainer> createState() => __MycontainerState();
}

List<Map> _points = <Map>[
  {"Title": "product"}
];
List<String> points1 = [];
List<Map> toList1() {
  _points.forEach((item) {
    points1.add(item.toString());
  });

  return _points.toList();
}

class __MycontainerState extends State<Mycontainer> {
  late InternetBloc internetBloc;

  @override
  void initState() {
    internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  @override
  void dispose() {
    internetBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Id: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Text(
                      "${widget.postData.userId}",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title: ",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                      width: 270.w,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text("${widget.postData.title}"),
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Content : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 3.h),
                      width: 280,
                      child: Text("${widget.postData.body}"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Like : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("${widget.postData.reactions!.likes}"),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  const Text(
                    "View : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("${widget.postData.views}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
