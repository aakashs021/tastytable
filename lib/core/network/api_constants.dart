
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = "https://api.spoonacular.com/recipes/";
  static String recipeSearch = "complexSearch?query=";
  static String apiKey = dotenv.env['SPOONACULAR_API_KEYD'] ?? "";
  static String detailSearch = "/information?apiKey=";

  static int apiKeyCount =0;

 static String setApiKey(){
    if(apiKeyCount==0){
      apiKeyCount++;
      return dotenv.env['SPOONACULAR_API_KEY']??"";
    }
    if(apiKeyCount==1){
      apiKeyCount++;
      return dotenv.env['SPOONACULAR_API_KEYA']??"";
    }
    if(apiKeyCount==2){
      apiKeyCount++;
      return dotenv.env['SPOONACULAR_API_KEYB']??"";
    }
    if(apiKeyCount==3){
      apiKeyCount++;
      return dotenv.env['SPOONACULAR_API_KEYC']??"";
    }
    apiKeyCount=0;
    return dotenv.env['SPOONACULAR_API_KEYD']??"";
  }
}
//api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=YOUR_API_KEY
// https://api.spoonacular.com/recipes/{id}/information?apiKey=YOUR_API_KEY
