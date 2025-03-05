import 'package:dartz/dartz.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';

abstract class UsecaseRecipeDetail {
  Future<Either<String,RecipeDetailModel>> call({required String id});
}