import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/detail/usecase_recipe_detail.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/domain/repository/recipe_detail_repository.dart';
import 'package:tastytable/service_locator.dart';

class RecipeDetailUsecase implements UsecaseRecipeDetail {
  @override
  Future<Either<String, RecipeDetailModel>> call({required String id}) async{
  final Either<String, RecipeDetailModel> result = await ServiceLocator.sl<RecipeDetailRepository>().getIndividualRecipe(id: id);

  return result;
  }
}