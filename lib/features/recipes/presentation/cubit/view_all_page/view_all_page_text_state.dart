import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

class ViewAllPageTextState {}

class ViewAllPageTextStateSuccess extends ViewAllPageTextState{
  List<RecipeHomeModel> recipes;
  ViewAllPageTextStateSuccess({required this.recipes});
}

class ViewAllPageTextStateFailure extends ViewAllPageTextState{}