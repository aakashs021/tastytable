import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

Widget shimmerLoading() {
  return ListView.builder(
    padding: EdgeInsets.all(5),
    itemCount: 5, 
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.all(5),
        width: 200,
        child: Stack(
          children: [
            Positioned.fill(
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
            ),
            Positioned(
              bottom: 0,
              child: Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(5),
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerContainerColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
