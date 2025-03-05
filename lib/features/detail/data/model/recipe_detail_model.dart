import 'package:tastytable/features/detail/domain/entity/recipe_detail_enitity.dart';

class RecipeDetailModel extends RecipeDetailEnitity {
  RecipeDetailModel(
      {required super.id,
      required super.title,
      required super.image,
      required super.instructions,
      required super.readyInMinutes,
      required super.ingredients,
      required super.isVeg,
      required super.serving,
      required super.summary});

  factory RecipeDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RecipeDetailModel(
      id: json['id'] ?? '0',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      instructions: cleanText(json['instructions'] ?? ''),
      readyInMinutes: (json['readyInMinutes'] ?? 0).toString(),
      ingredients: json['extendedIngredients'] ?? [],
      isVeg: json['vegetarian'] ?? false,
      serving: (json['servings'] ?? 0).toString(),
      summary: cleanText(json['summary'] ?? ''),
    );
  }
 static String cleanText(String input) {
    if(input.isEmpty){
      return '';
    }
  // Remove HTML tags
  RegExp regExp = RegExp(r'<[^>]*>');
  String cleanedText = input.replaceAll(regExp, '');

  // Remove extra characters like \u003Cb\u003E, \u003C/b\u003E, etc.
  cleanedText = cleanedText.replaceAll(RegExp(r'\\u003C[^>]*\\u003E'), '');

  // Remove any extra formatting marks like <b> or other special entities
  cleanedText = cleanedText.replaceAll(RegExp(r'&[^;]+;'), '');

  // Remove links (anchor tags)
  cleanedText = cleanedText.replaceAll(RegExp(r'\<a.*?\>(.*?)\<\/a\>', dotAll: true), '1');

  // Optional: You can add more cleaning rules based on the data you want to extract
  // Remove extra spaces at the beginning and end of the string
  cleanedText = cleanedText.trim();

  // Return the cleaned text
  return cleanedText;
}
}
