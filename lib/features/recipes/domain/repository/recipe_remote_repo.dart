import 'package:dartz/dartz.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';

abstract class RecipeRemoteRepo {

 Future<Either<String,List<RecipeHomeModel>>> getItalianCusine({required String cusine});

}