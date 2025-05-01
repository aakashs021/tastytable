import 'package:dartz/dartz.dart';

abstract class UsecaseForgotPassword {
  Future<Either<String,String>> call({ required String email});
}