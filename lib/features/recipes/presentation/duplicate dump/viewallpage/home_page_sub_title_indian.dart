// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tastytable/core/configs/theme/app_colors.dart';
// import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
// import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_indian.dart';
// import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_state.dart';
// import 'package:tastytable/router/app_router_constants.dart';

// Widget homePageSubTitleIndian(
//     {required String title, required BuildContext context}) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), title),
//       Expanded(child: SizedBox()),
//       BlocBuilder<ViewAllPageTextCubitIndian, ViewAllPageTextState>(
//         builder: (context, state) {
//           if (state is ViewAllPageTextStateFailure) {
//             return SizedBox();
//           }
//           List<RecipeHomeModel> recipes = [];
//           if (state is ViewAllPageTextStateSuccess) {
//             recipes = state.recipes;
//           }
//           return InkWell(
//             onTap: () {
//               GoRouter.of(context).pushNamed(
//                   AppRouterConstants.viewAllPageRouteName,
//                   pathParameters: {'title': title},
//                   extra: recipes);
//             },
//             child: Text(
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.recipeViewAllTextColor,
//                     decoration: TextDecoration.underline),
//                 'View All'),
//           );
//         },
//       ),
//       SizedBox(
//         width: 10,
//       )
//     ],
//   );
// }
