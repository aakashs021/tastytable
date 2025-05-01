import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {

  static late SharedPreferences _pref;
  static init()async{
    _pref = await SharedPreferences.getInstance();
   bool? isDarkMode= _pref.getBool('isDark');
   if(isDarkMode==null){
              _pref.setBool('isDark', false);
   }
  }
 static setDarkModeData({required bool isDarkMode}){
        
          _pref.setBool('isDark', isDarkMode);
        
  }

 static bool? getDarkTheme(){

 return  _pref.getBool('isDark');
  }
}