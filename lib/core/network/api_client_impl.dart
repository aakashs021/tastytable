import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytable/core/network/api_client.dart';
import 'api_constants.dart';

class ApiClientImpl implements ApiClient {
  @override
  Future<dynamic> getRequest(String endpoint) async {
    try {
      final apiKey = await ApiConstants.getApiKey();
      final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.recipeSearch}$endpoint&apiKey=$apiKey",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("GET request error: $e");
    }
  }

  @override
  Future<dynamic> getIndividualRecipe({required String id}) async {
    try {
      final apiKey = await ApiConstants.getApiKey();
      final url = Uri.parse(
        "${ApiConstants.baseUrl}$id${ApiConstants.detailSearch}$apiKey",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load recipe details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("GET recipe detail error: $e");
    }
  }
}
