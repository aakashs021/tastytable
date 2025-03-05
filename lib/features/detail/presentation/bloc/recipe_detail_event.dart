class RecipeDetailEvent {}

class RecipeDetailGetIndividualRecipeEvent extends RecipeDetailEvent{
  String id;
  RecipeDetailGetIndividualRecipeEvent({required this.id});
}