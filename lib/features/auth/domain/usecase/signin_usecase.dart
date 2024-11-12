import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/usecase.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class SigninUseCase implements Usecase<Either, UserModel, Null> {
  @override
  Future<Either> call(
      {required UserModel params1, required Null params2}) async {
    try {
      return await ServiceLocator.sl<AuthRepostory>()
          .signIn(userModel: params1);
    } catch (e) {
      return Left(
          "Unexpected error: ${e.toString()}");
    }
  }
}
