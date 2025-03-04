import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/usecase_settings.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class GetUserNameUsecase implements UsecaseSettings<Either<String,String>>{
  @override
  Future<Either<String,String>> call() async{
    Either<String,String> result=  await ServiceLocator.sl<SettingsRepository>().getUserName();
    return result;
  }
  
}