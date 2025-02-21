import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/auth/usecase_get_user.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class GetUserUsecase extends UsecaseGetUser<Either<String, UserModel>> {
  @override
  Future<Either<String, UserModel>> call() async {
    try {
      Either result = ServiceLocator.sl<AuthRepostory>().getUser();
      String? email = result.fold(
        (l) => l,
        (r) => r,
      );
      if (email != null) {
        Either<String,UserModel> result = await ServiceLocator.sl<FirestoreRepository>()
            .getUserDetail(email: email);
        return result;
      }
      return left("User data not found");
    } catch (e) {
      return left("error occured during fetching data");
    }
  }
}
