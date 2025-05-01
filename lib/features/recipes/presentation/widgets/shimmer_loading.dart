import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

Widget shimmerLoading(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  // double h = MediaQuery.of(context).size.height;
  return ListView.builder(
    padding: EdgeInsets.all(5),
    itemCount: 5,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.all(5),
        width: w * 0.5,

        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.shimmerContainerColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    },
  );
}
