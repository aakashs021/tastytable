import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tastytable/core/network/api_key_firebase.dart';

class ApiConstants {
  static String baseUrl = "https://api.spoonacular.com/recipes/";
  static String recipeSearch = "complexSearch?query=";
  static String detailSearch = "/information?apiKey=";

  static Future<String> getApiKey() async {
    int index = await ApiKeyFirebase.getLeastUsedKeyIndexAndUpdate();

    final Map<int, String> keyMap = {
      0: dotenv.env['SPOONACULAR_API_KEY']??"",
      1: dotenv.env['SPOONACULAR_API_KEYA']??"",
      2: dotenv.env['SPOONACULAR_API_KEYB']??"",
      3: dotenv.env['SPOONACULAR_API_KEYC']??"",
      4: dotenv.env['SPOONACULAR_API_KEYD']??"",
      5: dotenv.env['SPOONACULAR_API_KEYE']??"",
      6: dotenv.env['SPOONACULAR_API_KEYF']??"",
      7: dotenv.env['SPOONACULAR_API_KEYG']??"",
      8: dotenv.env['SPOONACULAR_API_KEYH']??"",
      9: dotenv.env['SPOONACULAR_API_KEYI']??"",
    };

    return keyMap[index] ?? dotenv.env['SPOONACULAR_API_KEYJ'] ?? '';
  }
}
