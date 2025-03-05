import 'package:tastytable/features/detail/domain/entity/ingredients_entity.dart';

class IngredientsModel extends IngredientsEntity {
  IngredientsModel({required super.ingredientName, required super.ingredientAmount, required super.ingredientUnit});

  factory IngredientsModel.fromJson({required Map json}){
    return IngredientsModel(ingredientName: json['name'], ingredientAmount: json['amount'].toString(), ingredientUnit: json['unit']);
  }
}