import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

class SearchState {}

class SearchIntitalState extends SearchState{}

class SearchLoaindgState extends SearchState{}

class SearchFailureState extends SearchState{}

class SearchSuccessState extends SearchState{
  List<RecipeHomeModel> model;
  SearchSuccessState({required this.model});
}