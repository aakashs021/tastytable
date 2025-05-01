import 'package:flutter/material.dart';

Widget SearchPageFailure({required String searchText}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sorry!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // Adds spacing between the texts
          Container(
            child: Text(
              'No recipes found for "$searchText". Please try a different search.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ),
    ),
  );
}