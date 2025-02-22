import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/settings_get_login_method_usecase.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class GetLoginMethodUsecase implements SettingsGetLoginMethodUsecase<Either<bool,bool>>{
  @override
  Either<bool,bool> call() {
   Either<bool,bool> result = ServiceLocator.sl<SettingsRepository>().getLoginMethod();
   return result;
  }
}