import 'package:tastytable/features/recipes/domain/entity/recipe_home.dart';

class RecipeHomeModel extends RecipeHome{
  RecipeHomeModel({required super.id, required super.title, required super.image});

  factory RecipeHomeModel.fromJson(Map<String , dynamic> json){
    return RecipeHomeModel(id: json['id'], title: json['title'], image: json['image']);
  }
}