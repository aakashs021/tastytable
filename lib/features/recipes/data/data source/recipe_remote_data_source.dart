import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/service_locator.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeHomeModel>> getItalianCusine({required String cusine});
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  @override
  Future<List<RecipeHomeModel>> getItalianCusine({required String cusine}) async {
    try {
      final data = await ServiceLocator.sl<ApiClient>().getRequest(cusine);
      List result = data['results'];
      List<RecipeHomeModel> finalList = [];
      for (Map<String, dynamic> food in result) {
        RecipeHomeModel model = RecipeHomeModel.fromJson(food);
        finalList.add(model);
        // print(model.id);
      }
      // print(result);
      return finalList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
