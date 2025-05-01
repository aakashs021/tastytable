import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/search/usecase_search.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/search/domain/repository/search_repository.dart';
import 'package:tastytable/service_locator.dart';

class SearchUsecase implements UsecaseSearch {
  @override
  Future<Either<String, List<RecipeHomeModel>>> call({required String searchText})async {
  Either<String,List<RecipeHomeModel>> result=  await ServiceLocator.sl<SearchRepository>().onSearch(searchText: searchText);

  return result;

  }
}