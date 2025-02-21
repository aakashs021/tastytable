
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = "https://api.spoonacular.com";
  static String recipeSearch = "/recipes/complexSearch?query=";
  static String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? "";
}
//api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=YOUR_API_KEY
