// import 'package:shared_preferences/shared_preferences.dart';

// class ApiPreference {
//   static late SharedPreferences _pref;
//   static init()async{
//     _pref = await SharedPreferences.getInstance();
//     int? apiCode = _pref.getInt('apiCode');
//     if(apiCode==null){
//       _pref.setInt('apiCode', 0);
//     }
//   }

//   static setApiCode({required int apiCode}){
//     if(apiCode>10){
//       apiCode=0;
//     }else{
//     apiCode++;
//     }
//      _pref.setInt('apiCode', apiCode);
//   }

//   static int? getApiCode(){
//     return _pref.getInt('apiCode');
//   }
// }