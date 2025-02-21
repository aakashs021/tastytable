import 'package:flutter/material.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/cuisines/home_page_list_british.dart';
import 'package:tastytable/features/recipes/presentation/widgets/cuisines/home_page_list_indian.dart';
import 'package:tastytable/features/recipes/presentation/widgets/cuisines/home_page_list_view_italian.dart';
import 'package:tastytable/features/recipes/presentation/widgets/viewallpage/home_page_sub_title_british.dart';
import 'package:tastytable/features/recipes/presentation/widgets/viewallpage/home_page_sub_title_indian.dart';
import 'package:tastytable/features/recipes/presentation/widgets/viewallpage/home_page_sub_title_italian.dart';

Widget HomePageRecipeView({required Cuisines cuisines,required BuildContext context}) {
 

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
            child: pageSubType(cuisines: cuisines, context: context),),
        SizedBox(
          height: 170,
          child: pageType(cuisines: cuisines),
        ),
      ],
    ),
  );
}

 String cuisinesType({required Cuisines cuisines}) {
    if (cuisines == Cuisines.british) {
      return "British Cuisine";
    }
    if (cuisines == Cuisines.indian) {
      return "Indian Cuisine";
    }
    return 'Italian Cuisine';
  }

Widget pageSubType({required Cuisines cuisines,required BuildContext context}){
      if (cuisines == Cuisines.british) {
        return homePageSubTitleBritish(title: cuisinesType(cuisines: cuisines), context: context);
      }
       if (cuisines == Cuisines.indian) {
        return homePageSubTitleIndian(title: cuisinesType(cuisines: cuisines), context: context);
    }
    return homePageSubTitleItalian(title: cuisinesType(cuisines: cuisines), context: context);
}

Widget pageType({required Cuisines cuisines}){
      if (cuisines == Cuisines.british) {
        return HomePageRecipeListBritish(cusines: cuisines);
      }
       if (cuisines == Cuisines.indian) {
      return HomePageRecipeListIndian(cusines: cuisines);
    }
    return HomePageRecipeListItalian(cusines: cuisines);
}