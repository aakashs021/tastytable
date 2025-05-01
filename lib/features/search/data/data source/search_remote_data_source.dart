import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/service_locator.dart';
import 'package:http/http.dart' as http;

abstract class SearchRemoteDataSource {
  Future<List<RecipeHomeModel>> onSearch({required String searchText});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<List<RecipeHomeModel>> onSearch({required String searchText}) async {
    try {
      Map<String, dynamic> data = await ServiceLocator.sl<ApiClient>()
          .getRequest(searchText) as Map<String, dynamic>;

      List result = data['results'];
      List<RecipeHomeModel> recipes = [];
      for (Map<String, dynamic> rec in result) {
        RecipeHomeModel model = RecipeHomeModel.fromJson(rec);
        bool isValid = await _isImageValid(model.image);
        if (isValid) {
          recipes.add(model);
        }
      }
      return recipes;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> _isImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200; // Only keep images that return 200 OK
    } catch (e) {
      return false;
    }
  }
}
