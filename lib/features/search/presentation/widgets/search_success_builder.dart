import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/router/app_router_constants.dart';

class SearchSuccessBuilder extends StatelessWidget {
  final List<RecipeHomeModel> recipes;
  const SearchSuccessBuilder({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                RecipeHomeModel recipe = recipes[index];
                return InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    GoRouter.of(context).pushNamed(
                        AppRouterConstants.detailSearchPageRouteName,
                        pathParameters: {'id': recipe.id.toString()});
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          width: w * 0.3,
                          height: h * 0.125,
                          imageUrl: recipe.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                                child: Container(
                                  width: w * 0.3,
                                  height: h * 0.125,
                                  decoration: BoxDecoration(
                                      color: AppColors.shimmerContainerColor,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                baseColor: AppColors.shimmerBaseColor,
                                highlightColor:
                                    AppColors.shimmerHighlightColor);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: w * 0.5,
                        child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            recipe.title),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey.shade300,
                );
              },
              itemCount: recipes.length),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
