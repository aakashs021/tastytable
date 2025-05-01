import 'package:dartz/dartz.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/search/data/data%20source/search_remote_data_source.dart';
import 'package:tastytable/features/search/domain/repository/search_repository.dart';
import 'package:tastytable/service_locator.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<Either<String, List<RecipeHomeModel>>> onSearch({required String searchText}) async{
    try{

    List<RecipeHomeModel> result =  await ServiceLocator.sl<SearchRemoteDataSource>().onSearch(searchText: searchText);
    return right(result);
    }catch(e){
      return left("Something went wrong");
    }

  }
}