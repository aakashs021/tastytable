import 'package:dartz/dartz.dart';
import 'package:tastytable/features/settings/data/model/change_password_error_message_model.dart';

abstract class SettingsRepository {
  Future<Either<String,String>> getUserName();
  Future<Either<String,String>> updateUserName({required String newUserName});
  Either<bool,bool> getLoginMethod();
  Future<Either<ChangePasswordErrorMessageModel,bool>> checkPasswordAndUpdate({required String currentPassword,required String newPassword});
  Future<Either<String,bool>> deleteAccount({required String password, required String? reason});
  Future<Either<String,bool>> deleteGoogleAccount({required String? reason});
}