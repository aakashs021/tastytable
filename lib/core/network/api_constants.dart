
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tastytable/core/utils/shared%20preference/api_preference.dart';

class ApiConstants {
  static String baseUrl = "https://api.spoonacular.com/recipes/";
  static String recipeSearch = "complexSearch?query=";
  static String apiKey = setApiKey();
  static String detailSearch = "/information?apiKey=";

  static int apiKeyCount =ApiPreference.getApiCode()!;

 static String setApiKey(){
    if(apiKeyCount==0){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEY']??"";
    }
    if(apiKeyCount==1){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYA']??"";
    }
    if(apiKeyCount==2){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYB']??"";
    }
    if(apiKeyCount==3){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYC']??"";
    }
     if(apiKeyCount==4){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYD']??"";
    }
     if(apiKeyCount==5){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYE']??"";
    }
    if(apiKeyCount==6){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYF']??"";
    }
    if(apiKeyCount==7){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYG']??"";
    }
    if(apiKeyCount==8){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYH']??"";
    }
    if(apiKeyCount==9){
      ApiPreference.setApiCode(apiCode: apiKeyCount);
      return dotenv.env['SPOONACULAR_API_KEYI']??"";
    }
          ApiPreference.setApiCode(apiCode: apiKeyCount);

    return dotenv.env['SPOONACULAR_API_KEYJ']??"";
  }
}
// api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=YOUR_API_KEY
// https://api.spoonacular.com/recipes/{id}/information?apiKey=YOUR_API_KEY
// https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=YOUR_API_KEY