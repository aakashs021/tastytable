import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/value_notifier/text_loading_val_noti.dart';

class ViewAllPage extends StatelessWidget {
  final String title;
  final List<RecipeHomeModel> recipes;
  ViewAllPage({super.key, required this.title, required this.recipes});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isloaded = ValueNotifier<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                        isloaded.value=true;
                        // print('run');
                        return  Image(image: imageProvider, fit: BoxFit.fill);
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(valueListenable: isloaded,
                 builder: (context, value, child) {
                  return value? Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  child: Text(
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                      recipe.title),
                ):SizedBox();
                },),
               
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
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
