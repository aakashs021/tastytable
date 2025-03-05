import 'package:dartz/dartz.dart';
import 'package:tastytable/features/detail/data/data%20source/recipe_detail_remote_datasource.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/domain/repository/recipe_detail_repository.dart';
import 'package:tastytable/service_locator.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  @override
  Future<Either<String, RecipeDetailModel>> getIndividualRecipe({required String id})async {
    try{
   final RecipeDetailModel model=  await ServiceLocator.sl<RecipeDetailRemoteDatasource>().getIndividualRecipe(id: id);
   return right(model);
    }catch (e){
      return left("Something went wrong");
    }

  }
}