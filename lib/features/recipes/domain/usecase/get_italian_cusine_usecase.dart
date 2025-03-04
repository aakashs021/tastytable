import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/recipe/recipe_usecase.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/domain/repository/recipe_remote_repo.dart';
import 'package:tastytable/service_locator.dart';

class GetCusineUsecase implements RecipeUsecase<Either<String,List<RecipeHomeModel>>,String>{
  @override
  Future<Either<String,List<RecipeHomeModel>>> call({required String cusine}) async{
    try{
    Either<String,List<RecipeHomeModel>> result =  await ServiceLocator.sl<RecipeRemoteRepo>().getItalianCusine(cusine: cusine);
    return result;
    }catch(e){
      return left('Error');
    }
  }
}