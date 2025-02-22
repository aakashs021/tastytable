import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_recipe_view.dart';
import 'package:tastytable/features/recipes/presentation/widgets/home_page_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async{
        if(didPop){
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
                child: Text(style: TextStyle(color: Colors.black), 'Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Pop
                child: Text(style: TextStyle(color: Colors.red), 'Exit'),
              ),
            ],
          ),
        );
        // If user presses "Exit", return true to pop the screen
        if(shouldPop==true){
          context.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                HomePageTitle(context: context),
                HomePageRecipeView(
                    cuisines: Cuisines.british, context: context),
                HomePageRecipeView(
                    cuisines: Cuisines.italian, context: context),
                HomePageRecipeView(cuisines: Cuisines.indian, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
