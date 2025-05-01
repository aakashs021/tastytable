import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipe_state.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/empty_data_text.dart';
import 'package:tastytable/features/recipes/presentation/widgets/shimmer_loading.dart';
import 'package:tastytable/router/app_router_constants.dart';

class HomePageRecipeList<TCubit extends Cubit<RecipeCubitState>>
    extends StatelessWidget {
  final Cuisines cuisines;

  HomePageRecipeList({super.key, required this.cuisines});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocBuilder<TCubit, RecipeCubitState>(
      builder: (context, state) {
        if (state is RecipeCubitLoading) {
          return shimmerLoading(context);
        }
        if (state is RecipeCubitFailure) {
          viewAllCubitSuccessWorker(
              context: context, cuisines: cuisines, data: [], state: state);
          return EmptyTextData();
        }
        List<RecipeHomeModel> data = [];
        if (state is RecipeCubitSuccess) {
          data = state.recipes;
        }
        viewAllCubitSuccessWorker(
            context: context, cuisines: cuisines, data: data, state: state);
        return ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            RecipeHomeModel recipe = data[index];
            return InkWell(
              onTap: () {
                String id = recipe.id.toString();
                GoRouter.of(context).pushNamed(
                    AppRouterConstants.detailHomePageRouteName,
                    pathParameters: {'id': id});
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: w * 0.5,
                height: h * 0.25,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          height: h * 0.25,
                          imageUrl: recipe.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return shimmerLoading(context);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.all(5),
                          width: w * 0.45,
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

viewAllCubitSuccessWorker(
    {required BuildContext context,
    required Cuisines cuisines,
    required List<RecipeHomeModel> data,
    required RecipeCubitState state}) {
  if (state is RecipeCubitSuccess) {
    if (cuisines == Cuisines.british) {
      context.read<ViewAllPageTextCubitBritish>().dataExists(recipes: data);
    } else if (cuisines == Cuisines.indian) {
      context.read<ViewAllPageTextCubitIndian>().dataExists(recipes: data);
    } else {
      context.read<ViewAllPageTextCubitItalian>().dataExists(recipes: data);
    }
  } else {
    if (cuisines == Cuisines.british) {
      context.read<ViewAllPageTextCubitBritish>().dataNotExist();
    } else if (cuisines == Cuisines.indian) {
      context.read<ViewAllPageTextCubitIndian>().dataNotExist();
    } else {
      context.read<ViewAllPageTextCubitItalian>().dataNotExist();
    }
  }
}
