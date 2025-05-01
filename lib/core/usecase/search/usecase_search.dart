import 'package:dartz/dartz.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

abstract class UsecaseSearch {
  Future<Either<String,List<RecipeHomeModel>>> call({required String searchText});
}