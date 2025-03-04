import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/usecase_check_password_and_update.dart';
import 'package:tastytable/features/settings/data/model/change_password_error_message_model.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class CheckPasswordAndUpdateUsecase implements UsecaseCheckPasswordAndUpdate<Either<ChangePasswordErrorMessageModel,bool>,String,String> {
  @override
  Future<Either<ChangePasswordErrorMessageModel, bool>> call({required String params1, required String params2}) async{
    Either<ChangePasswordErrorMessageModel,bool> result=  await ServiceLocator.sl<SettingsRepository>().checkPasswordAndUpdate(currentPassword: params1, newPassword: params2);
    return result;
  } 
}