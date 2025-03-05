

import 'package:flutter/material.dart';

Widget detailMinutesWidget({required String readyInMinutes}) {
  TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          Icons.timer_sharp,
          size: 25,
        ),
      ),
      Text(
        readyInMinutes,
        style: style,
      ),
      Text(
        ' min',
        style: style,
      )
    ],
  );
}
