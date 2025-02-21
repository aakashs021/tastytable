import 'package:flutter/material.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/pages/s_out.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_recipe_view.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              HomePageTitle(),
              HomePageRecipeView(cuisines: Cuisines.british,context: context),
              HomePageRecipeView(cuisines: Cuisines.italian,context: context),
              HomePageRecipeView(cuisines: Cuisines.indian ,context: context),
              ElevatedButton(
                  onPressed: () {
                    signOutFunction(context: context);
                  },
                  child: const Text('signout')),
            ],
          ),
        ),
      ),
    );
  }
}
