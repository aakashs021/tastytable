
import 'package:flutter/material.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

Widget verticalDividerContainer() {
  return Container(
    width: 3,
    height: 30,
    decoration: BoxDecoration(
        color: AppColors.detailVerticalDividerContainer, borderRadius: BorderRadius.circular(50)),
  );
}