import 'package:dartz/dartz.dart';
import 'package:tastytable/features/settings/data/data%20sounce/settings_firebase_services.dart';
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
  Future<Either<String, String>> updateUserName({required String newUserName}) async{
    try{
     String userName= await serviceLocator.updateUserName(userName: newUserName);
     
     return right(userName);
    }catch(e){
      return left('Unsuccessfull');
    }

  }
  
  @override
  Either<bool, bool> getLoginMethod() {
    try{

  bool login=  serviceLocator.getLoginMethod();
    return right(login);
    }catch(e){
      return left(false);
    }
  }
}
