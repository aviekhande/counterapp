import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMyContainer extends StatelessWidget {
  const ShimmerMyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          shimmerContainer(context),
          shimmerContainer(context),
          shimmerContainer(context)
        ],
      ),
    );
  }

  Widget shimmerContainer(context) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(8.h),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerRow(context, "User Id: ", 100.w),
          SizedBox(height: 8.h),
          _buildShimmerRow(context, "Title: ", 250.w),
          SizedBox(height: 8.h),
          _buildShimmerRow(context, "Content: ", 230.w, isMultiline: true),
          SizedBox(height: 8.h),
          _buildShimmerRow(context, "Like: ", 50.w),
          SizedBox(height: 8.h),
          _buildShimmerRow(context, "View: ", 50.w),
        ],
      ),
    );
  }

  Widget _buildShimmerRow(BuildContext context, String label, double width,
      {bool isMultiline = false}) {
    return Row(
      crossAxisAlignment:
          isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.sp),
        ),
        SizedBox(width: 8.w),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 18.h,
            width: width,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
