import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(5),
                  width: 180,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
