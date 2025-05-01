import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

Widget SearchPageLoading({required BuildContext context}) {
  double w = MediaQuery.of(context).size.width;

  double h = MediaQuery.of(context).size.height;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Shimmer.fromColors(
                  child: Container(
                    width: w * 0.3,
                    height: h * 0.125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.shimmerContainerColor),
                  ),
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor),
              SizedBox(
                width: 20,
              ),
              Shimmer.fromColors(
                  child: Container(
                    width: w * 0.5,
                    height: h * 0.035,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.shimmerContainerColor),
                  ),
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.shade500,
          );
        },
        itemCount: 6),
  );
}
