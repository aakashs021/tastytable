import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/auth/usecase_forgot_password.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class ForgotPasswordUsecase implements UsecaseForgotPassword {
  @override
  Future<Either<String, String>> call({required String email}) async{
  Either<String, String> result=  await ServiceLocator.sl<AuthRepostory>().forgotPassword(email: email);
  return result;
  }
}