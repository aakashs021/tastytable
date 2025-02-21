import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

class RecipeCubitState {}

class RecipeCubitInitial extends RecipeCubitState {}

class RecipeCubitSuccess extends RecipeCubitState {
  List<RecipeHomeModel> recipes;
  RecipeCubitSuccess(this.recipes);
}

class RecipeCubitFailure extends RecipeCubitState {}

class RecipeCubitLoading extends RecipeCubitState {}