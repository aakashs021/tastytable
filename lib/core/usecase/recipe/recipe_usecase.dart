abstract class RecipeUsecase<Type,String> {
  Future<Type> call({required String cusine});
}