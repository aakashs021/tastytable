import 'package:dartz/dartz.dart';
import 'package:tastytable/features/settings/data/data%20sounce/settings_firebase_services.dart';
import 'package:tastytable/features/settings/data/model/change_password_error_message_model.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static var serviceLocator = ServiceLocator.sl<SettingsFirebaseServices>();
  @override
  Future<Either<String, String>> getUserName() async {
    try {
      String userName = await serviceLocator.getUserName();
      return right(userName);
    } catch (e) {
      return left('Unsuccessfull');
    }
  }

  @override
  Future<Either<String, String>> updateUserName(
      {required String newUserName}) async {
    try {
      String userName =
          await serviceLocator.updateUserName(userName: newUserName);

      return right(userName);
    } catch (e) {
      return left('Unsuccessfull');
    }
  }

  @override
  Either<bool, bool> getLoginMethod() {
    try {
      bool login = serviceLocator.getLoginMethod();
      if(!login){
        return left(false);
      }
      return right(login);
    } catch (e) {
      return left(false);
    }
  }

  @override
  Future<Either<ChangePasswordErrorMessageModel, bool>> checkPasswordAndUpdate(
      {required String currentPassword, required String newPassword}) async {
    try {
      bool result = await serviceLocator.checkPasswordAndChange(
          currentPassword: currentPassword, newPassword: newPassword);
      return right(result);
    } catch (e) {
      ChangePasswordErrorMessageModel errorMessage;
      String errorCode = e.toString();
      print(errorCode);

      switch (errorCode) {
        case 'Exception: invalid-credential':
          errorMessage = ChangePasswordErrorMessageModel(
              title: "Your current password is incorrect",
              message: "Please try again!");

          break;
        case 'Exception: weak-password':
          errorMessage = ChangePasswordErrorMessageModel(
              title: "Your new password is weak",
              message: "Password should atleast contain  six characters.");
          break;
        case 'requires-recent-login':
          errorMessage = ChangePasswordErrorMessageModel(
              title: "Requires to login again.",
              message: "Please log out and then sign in.");
          break;
        default:
          errorMessage = ChangePasswordErrorMessageModel(
              title: "Something went wrong",
              message: "Please try again later.");
      }

      return left(errorMessage); // Return error message to UI
    }
  }
  
  @override
  Future<Either<String, bool>> deleteAccount({required String password, required String? reason}) async{
      try{
      bool result =  await serviceLocator.deleteAccount(password: password,reason:  reason);
      return right(result);
      }catch(e){
        String errorMessage;
        String errorCode =e.toString();
        
        switch (errorCode){
          case 'Exception: invalid-credential':
          errorMessage = "Your password is invalid. Please try again";
          case 'requires-recent-login':
          errorMessage= "Requires to login again. Please log out and then sign in.";
          default:
          errorMessage= "Something went wrong. Try again later.";
        }
        return left(errorMessage);
      }
  }
  
  @override
  Future<Either<String, bool>> deleteGoogleAccount({required String? reason}) async{
    try{

   bool result= await serviceLocator.deleteGoogleAccount(reason: reason);
   if(result){
    return right(true);
   }
   return left('Google account deletion failed');
  } catch(e){
   return left('error occunred');
  }
    
}
}