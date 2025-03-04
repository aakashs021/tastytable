import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/usecase_settings_update.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class UpdateUserNameUsecase implements UsecaseSettingsUpdate<Either<String,String>,String> {
  @override
  Future<Either<String, String>> call({required String params}) async{
   Either<String,String> result = await ServiceLocator.sl<SettingsRepository>().updateUserName(newUserName: params);
   return result; 
  }
}