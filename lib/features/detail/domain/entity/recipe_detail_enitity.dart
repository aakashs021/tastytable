class RecipeDetailEnitity {
  int id;
  String title;
  String image;
  String instructions;
  String readyInMinutes;
  List ingredients;
  bool isVeg;
  String summary;
  String serving;
  RecipeDetailEnitity({required this.id,required this.title,required this.image,required this.instructions,required this.readyInMinutes,required this.ingredients, required this.isVeg,required this.serving,required this.summary});

}