import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/usecase_delete_account.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class AccounDeleteUsecase implements UsecaseDeleteAccount<Either<String,bool>,String,String?> {
  @override
  Future<Either<String, bool>> call({required String params1,required String? params2}) async{
    Either<String,bool> result=  await ServiceLocator.sl<SettingsRepository>().deleteAccount(password: params1,reason:  params2);
    return result;
  }
}