import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/domain/usecase/get_italian_cusine_usecase.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipe_state.dart';
import 'package:tastytable/features/recipes/presentation/enum/cuisines.dart';
import 'package:tastytable/service_locator.dart';
import 'package:http/http.dart' as http;

class RecipesCubitIndian extends Cubit<RecipeCubitState> {
  RecipesCubitIndian() : super(RecipeCubitInitial());

  getRecipes() async {
    emit(RecipeCubitLoading());

    Either<String, List<RecipeHomeModel>> result =
        await ServiceLocator.sl<GetCusineUsecase>().call(cusine: "Indian");

    result.fold(
      (error) => emit(RecipeCubitFailure()), 
      (recipes) async {
        List<RecipeHomeModel> validRecipes = [];

        for (RecipeHomeModel recipe in recipes) {
          bool isValid = await _isImageValid(recipe.image);
          if (isValid) {
            validRecipes.add(recipe);
          }
        }

        if (validRecipes.isEmpty) {
          emit(RecipeCubitFailure());
        } else {
          emit(RecipeCubitSuccess(validRecipes));
        }
      },
    );
  }

  Future<bool> _isImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200; // Only keep images that return 200 OK
    } catch (e) {
      return false;
    }
  }

  String cuisineType(Cuisines cuisines){
    if(cuisines==Cuisines.british){
      return 'British';
    }
    else if(cuisines==Cuisines.indian){
      return 'Indian';
    }else if(cuisines==Cuisines.french){
      return 'French';
    }
    else if(cuisines==Cuisines.american){
      return 'American';
    }
    else if(cuisines==Cuisines.greek){
      return 'Greek';
    }
    else if(cuisines==Cuisines.biriyani){
      return 'Biriyani';
    }
    else{
      return 'Italian';
    }
  }
}


