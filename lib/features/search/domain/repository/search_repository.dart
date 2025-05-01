import 'package:dartz/dartz.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

abstract class SearchRepository {
  Future<Either<String,List<RecipeHomeModel>>> onSearch({required String searchText});

}