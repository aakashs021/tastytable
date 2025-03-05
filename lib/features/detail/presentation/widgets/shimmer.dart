import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double sizedBoxHeight = h * 0.02;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
      child: Column(
        children: [
          shimmerContainer(height: h * 0.35),
          SizedBox(
            height: sizedBoxHeight,
          ),
          shimmerContainer(height: h * 0.055),
          SizedBox(
            height: sizedBoxHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerContainer(height: h * 0.09, width: w * 0.25),
              shimmerContainer(height: h * 0.09, width: w * 0.25),
              shimmerContainer(height: h * 0.09, width: w * 0.25),
            ],
          ),
          SizedBox(
            height: sizedBoxHeight,
          ),
          shimmerContainer(height: h * 0.17),
          SizedBox(
            height: sizedBoxHeight,
          ),
          shimmerContainer(height: h * 0.1),
        ],
      ),
    );
  }
}

Widget shimmerContainer(
    {required double height, double width = double.infinity}) {
  return Shimmer.fromColors(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.shimmerContainerColor),
      ),
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor);
}
