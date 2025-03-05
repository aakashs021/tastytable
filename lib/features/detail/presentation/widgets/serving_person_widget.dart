
import 'package:flutter/material.dart';

Widget servingPersonsWidget({required String people}) {
  return Row(
    children: [
      Text(
        people,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 7, bottom: 4.0),
        child: Icon(
          Icons.people_alt,
          size: 30,
        ),
      )
    ],
  );
}
