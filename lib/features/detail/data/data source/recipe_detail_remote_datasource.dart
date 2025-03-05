import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/service_locator.dart';

abstract class RecipeDetailRemoteDatasource {
  Future<RecipeDetailModel> getIndividualRecipe({required String id});
}

class RecipeDetailRemoteDatasourceImpl implements RecipeDetailRemoteDatasource{
  @override
  Future<RecipeDetailModel> getIndividualRecipe({required String id}) async{
    try{

    final  Map<String,dynamic> jsonData =  await ServiceLocator.sl<ApiClient>().getIndividualRecipe(id: id) as Map<String,dynamic>;
    RecipeDetailModel model = RecipeDetailModel.fromJson(json: jsonData);
    return model;
    }catch (e){
      throw Exception(e);
    }
  }

}