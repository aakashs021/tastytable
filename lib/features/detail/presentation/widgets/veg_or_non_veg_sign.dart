
import 'package:flutter/material.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';

Widget vegOrNonVegSign({required bool isVeg}) {
  String image = isVeg
      ? AppImages.detailPageVegetarianSign
      : AppImages.detailPageNonVegetarianSign;
  String text = isVeg ? "Veg" : "Non-Veg";
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        image,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      // Text(text)
    ],
  );
}
