import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/usecase_signout.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class SignoutUsecase extends UsecaseSignout<Either<String,String>> {
  @override
  Either<String,String> call() {
   Either<String,String> result= ServiceLocator.sl<AuthRepostory>().signOut();        
   return result;
  }

}