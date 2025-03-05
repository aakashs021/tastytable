import 'package:http/http.dart' as http;
import 'package:tastytable/core/network/api_client.dart';
import 'dart:convert';
import 'api_constants.dart';

class ApiClientImpl implements ApiClient {

  Future<dynamic> getRequest(String endpoint) async {
    final url = Uri.parse("${ApiConstants.baseUrl+ApiConstants.recipeSearch}$endpoint&apiKey=${ApiConstants.apiKey}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<dynamic> getIndividualRecipe({required String id})async{
  final url=  Uri.parse(ApiConstants.baseUrl + id +ApiConstants.detailSearch + ApiConstants.apiKey);
   final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
