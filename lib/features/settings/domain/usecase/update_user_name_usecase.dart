import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/settings_update_usecase.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class UpdateUserNameUsecase implements SettingsUpdateUsecase<Either<String,String>,String> {
  @override
  Future<Either<String, String>> call({required String params}) async{
   Either<String,String> result = await ServiceLocator.sl<SettingsRepository>().updateUserName(newUserName: params);
   return result; 
  }
}