import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/router/app_router_constants.dart';

Widget HomePageTitle({required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(style: TextStyle(fontSize: 25), "Explore"),
              Text('What would you like to eat?'),
            ],
          ),
          InkWell(
            onTap: () {
              GoRouter.of(context).pushNamed(AppRouterConstants.settingsRouteName);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              radius: 20,
              child: Icon(
                color: Colors.black,
                Icons.settings,
                size: 25,
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        width: double.infinity,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: Container(
              margin: EdgeInsets.all(4),
              height: 60,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
