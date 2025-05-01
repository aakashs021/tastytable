import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_list_british.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_sub_title_british.dart';

Widget HomePageRecipeView(
    {required Cuisines cuisines, required BuildContext context}) {
  context.read<RecipesCubitBritish>().getRecipes();
  context.read<RecipesCubitIndian>().getRecipes();
  context.read<RecipeCubitItalian>().getRecipes();
  double h = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: pageTypeSubTitle(cuisines: cuisines, context: context),
        ),
        SizedBox(
          height: h * 0.25,
          child: pageTypeList(cuisines: cuisines),
        ),
      ],
    ),
  );
}

Widget pageTypeSubTitle(
    {required Cuisines cuisines, required BuildContext context}) {
  String cuisinesNameType({required Cuisines cuisines}) {
    if (cuisines == Cuisines.british) {
      return "British Cuisine";
    }
    if (cuisines == Cuisines.indian) {
      return "Indian Cuisine";
    }
    return 'Italian Cuisine';
  }

  if (cuisines == Cuisines.british) {
    return homePageSubTitle<ViewAllPageTextCubitBritish>(
        title: cuisinesNameType(cuisines: cuisines), context: context);
  }
  if (cuisines == Cuisines.indian) {
    return homePageSubTitle<ViewAllPageTextCubitIndian>(
        title: cuisinesNameType(cuisines: cuisines), context: context);
  }
  return homePageSubTitle<ViewAllPageTextCubitItalian>(
      title: cuisinesNameType(cuisines: cuisines), context: context);
}

Widget pageTypeList({required Cuisines cuisines}) {
  if (cuisines == Cuisines.british) {
    return HomePageRecipeList<RecipesCubitBritish>(cuisines: cuisines);
  }
  if (cuisines == Cuisines.indian) {
    return HomePageRecipeList<RecipesCubitIndian>(cuisines: cuisines);
  }
  return HomePageRecipeList<RecipeCubitItalian>(cuisines: cuisines);
}
