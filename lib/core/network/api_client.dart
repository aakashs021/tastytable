abstract class ApiClient {
  Future<dynamic> getRequest(String endpoint);

  Future<dynamic> getIndividualRecipe({required String id});

}