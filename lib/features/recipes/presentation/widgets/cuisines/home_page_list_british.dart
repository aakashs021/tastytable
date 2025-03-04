import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipe_state.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/empty_data_text.dart';
import 'package:tastytable/features/recipes/presentation/widgets/shimmer_loading.dart';
import 'package:tastytable/router/app_router_constants.dart';

class HomePageRecipeListBritish extends StatelessWidget {
  final Cuisines cusines;
  
  HomePageRecipeListBritish({super.key, required this.cusines});

  @override
  Widget build(BuildContext context) {
    context.read<RecipesCubitBritish>().getRecipes();
    return BlocBuilder<RecipesCubitBritish, RecipeCubitState>(
      builder: (context, state) {
        if (state is RecipeCubitLoading) {
          return shimmerLoading();
        }
        if (state is RecipeCubitFailure) {
          context.read<ViewAllPageTextCubitBritish>().dataNotExist();
          return EmptyTextData();
        }
        List<RecipeHomeModel> data = [];
        if (state is RecipeCubitSuccess) {
          data = state.recipes;
        }
        context.read<ViewAllPageTextCubitBritish>().dataExists(recipes: data);
        return ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            RecipeHomeModel recipe = data[index];
            return InkWell(
              onTap: () {
                String id = recipe.id.toString();
                GoRouter.of(context).pushNamed(AppRouterConstants.detailHomePageRouteName,pathParameters: {'id':id});
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: 200,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          height: 200,
                          imageUrl: recipe.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return shimmerLoading();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.all(5),
                          width: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.recipeFoodTitleColor),
                              recipe.title),
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
