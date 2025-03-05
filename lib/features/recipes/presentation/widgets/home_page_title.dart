import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
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
              GoRouter.of(context)
                  .pushNamed(AppRouterConstants.detailHomePageRouteName,pathParameters: {'id':'2'});
            },
            child: CircleAvatar(
              backgroundColor: AppColors.recipeSettingsIconBackgroundColor,
              radius: 20,
              child: Icon(
                color: AppColors.recipeSettingsIconColor,
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
        child: InkWell(
          onTap: () {
            GoRouter.of(context)
                .pushNamed(AppRouterConstants.searchPageRouteName);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.black), // Border similar to TextField
              color: Colors.white, // Set the background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 3, // Spread of the shadow
                  blurRadius: 5, // Blur radius for the shadow
                  offset:
                      Offset(0, 4), // Position of the shadow (vertical shift)
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5, top: 3, bottom: 3),
                  height: 60,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.recipeSearchIconContainerColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppColors.recipeSearchIconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
