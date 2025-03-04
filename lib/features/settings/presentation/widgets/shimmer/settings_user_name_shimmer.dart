import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

Widget SettingsUserNameShimmer(){
  return Positioned(
          top: 12.5,
          left: 10,
          child: Stack(
            children: [
              Positioned(
                child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  period:
                      Duration(milliseconds: 1500), // Speed of shimmer effect
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.shimmerContainerColor,
                    ),
                  ),
                ),
              ),
            ]),);
}