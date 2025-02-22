import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either<String,String>> getUserName();
  Future<Either<String,String>> updateUserName({required String newUserName});
  Either<bool,bool> getLoginMethod();
}