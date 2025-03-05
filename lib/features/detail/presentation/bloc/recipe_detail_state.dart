import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';

class RecipeDetailState {}

class RecipeDetailSuccessState extends RecipeDetailState{
  RecipeDetailModel model;
  RecipeDetailSuccessState({required this.model});
}

class RecipeDetailInitialState extends RecipeDetailState{}

class RecipeDetailFailureState extends RecipeDetailState{}

class RecipeDetailLoadingState extends RecipeDetailState{}