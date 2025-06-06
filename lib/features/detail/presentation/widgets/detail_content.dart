import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/presentation/widgets/content_column_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/detail_minute_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/ingredients_content_column_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/serving_person_widget.dart';
import 'package:tastytable/features/detail/presentation/widgets/veg_or_non_veg_sign.dart';
import 'package:tastytable/features/detail/presentation/widgets/vertical_divider_container.dart';

class DetailContent extends StatelessWidget {
  final RecipeDetailModel recipe;
  DetailContent({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        // alignment: Alig,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              recipe.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 275),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
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
                        color: Colors.black26,
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
                  IngredientsContentColumnWidget(
                      ingredients: recipe.ingredients),
                  ContentColumnWidget(
                    title: 'Directions',
                    content: recipe.instructions,
                    colorCode: 3,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 10,
            child: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
