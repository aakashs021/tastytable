import 'package:dartz/dartz.dart';
import 'package:tastytable/features/recipes/data/data%20source/recipe_remote_data_source.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/domain/repository/recipe_remote_repo.dart';
import 'package:tastytable/service_locator.dart';

class RecipeRemoteRepoImpl implements RecipeRemoteRepo {
  @override
  Future<Either< String,List<RecipeHomeModel>>> getItalianCusine({required String cusine}) async{
    try{
    final List<RecipeHomeModel> result = await ServiceLocator.sl<RecipeRemoteDataSource>().getItalianCusine(cusine: cusine);
    return right(result);
    }catch(e){
     return left("Error occured while fetching");
    }
  }
}