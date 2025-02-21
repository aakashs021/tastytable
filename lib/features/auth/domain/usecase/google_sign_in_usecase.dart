import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/auth/usecase_google.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class GoogleSignInUsecase extends UsecaseGoogle<Either> {
  @override
  Future<Either<String, String>> call() async {
    try {
      return await ServiceLocator.sl<AuthRepostory>().googleSignIn();
    } catch (e) {
      return left(e.toString());
    }
  }
}
