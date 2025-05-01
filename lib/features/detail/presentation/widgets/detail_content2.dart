import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/presentation/widgets/content_column_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/detail_minute_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/ingredients_content_column_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/serving_person_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/veg_or_non_veg_sign.dart';
import 'package:tastytable/features/detail/presentation/widgets/vertical_divider_container.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContent2 extends StatelessWidget {
  final RecipeDetailModel recipe;

  DetailContent2({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white54,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.chevron_left_sharp,
                  color: Colors.black,
                )),
          ),
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
            imageUrl: recipe.image,
            height: 300,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerContainerColor,
                      // borderRadius: bor
                    ),
                  ),
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor);
            },
          )
              // Image.network(
              //   height: 300,
              //   recipe.image,
              //   fit: BoxFit.cover,
              // ),
              ),
        )
      ],
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          // margin: EdgeInsets.only(top: -30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.detailContentBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.detailContentTopDivider,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        maxLines: 5,
                        recipe.title,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailMinutesWidget(
                          readyInMinutes: recipe.readyInMinutes),
                      verticalDividerContainer(),
                      servingPersonsWidget(people: recipe.serving),
                      verticalDividerContainer(),
                      vegOrNonVegSign(isVeg: recipe.isVeg),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ContentColumnWidget(
                  title: 'Summary',
                  content: recipe.summary,
                ),
                IngredientsContentColumnWidget(ingredients: recipe.ingredients),
                ContentColumnWidget(
                  title: 'Directions',
                  content: recipe.instructions,
                  colorCode: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        title: 'Opening Website',
                        text:
                            'Please wait while we open the website. This may take a few moments. Thank you for your patience!',
                        onConfirmBtnTap: () async {
                          final Uri uri = Uri.parse(recipe.webLink);
                          context.pop();
                          if (!await launchUrl(uri)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AwesomeSnackbarContent(
                                title: "Oops! Website Not Opening",
                                message:
                                    "Looks like something went wrong. Please try again in a moment!",
                                contentType: ContentType.failure,
                              ),
                            ));
                          }
                        },
                        onCancelBtnTap: () {
                          context.pop();
                        },
                      );
                    },
                    child: Text('Go to website for more detail')),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
