
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = "https://api.spoonacular.com/recipes/";
  static String recipeSearch = "complexSearch?query=";
  static String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? "";
  static String detailSearch = "/information?apiKey=";
}
//api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=YOUR_API_KEY
// https://api.spoonacular.com/recipes/{id}/information?apiKey=YOUR_API_KEY
