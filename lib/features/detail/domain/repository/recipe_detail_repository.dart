import 'package:dartz/dartz.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';

abstract class RecipeDetailRepository {
  Future<Either<String,RecipeDetailModel>> getIndividualRecipe({required String id});
}