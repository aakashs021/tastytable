import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_recipe_view.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Don't pop
                child: Text(
                    style:
                        TextStyle(color: AppColors.recipePopUpCancelTextColor),
                    'Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // Pop
                },
                child: Text(style: TextStyle(color: Colors.red), 'Exit'),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.recipeSearchIconColor,
              onRefresh: () => _refresh(context: context),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  HomePageTitle(context: context),
                  HomePageRecipeView(
                      cuisines: Cuisines.british, context: context),
                  // HomePageRecipeView(
                  //     cuisines: Cuisines.italian, context: context),
                  // HomePageRecipeView(cuisines: Cuisines.indian, context: context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _refresh({required BuildContext context}) async {
  context.read<RecipesCubitBritish>().getRecipes();
  context.read<RecipesCubitIndian>().getRecipes();
  context.read<RecipeCubitItalian>().getRecipes();
}
