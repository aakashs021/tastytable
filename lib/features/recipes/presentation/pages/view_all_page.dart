import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

class ViewAllPage extends StatelessWidget {
  final String title;
  final List<RecipeHomeModel> recipes;
  ViewAllPage({super.key, required this.title, required this.recipes});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isloaded = ValueNotifier<bool>(false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView.separated(
        itemCount: recipes.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          RecipeHomeModel recipe = recipes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: recipe.image,
                      placeholder: (context, url) {
                        return ViewAllShimmerLoading();
                      },
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageBuilder: (context, imageProvider) {
                        isloaded.value = true;
                        return Image(image: imageProvider, fit: BoxFit.fill);
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: isloaded,
                  builder: (context, value, child) {
                    return value
                        ? Positioned(
                            left: 10,
                            top: 10,
                            right: 10,
                            child: Text(
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.viewAllRecipeTitleColor,
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis),
                                recipe.title),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ViewAllShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: AppColors.shimmerContainerColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
