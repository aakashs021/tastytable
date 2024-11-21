import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/usecase.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class SignupUsecase implements Usecase<Either, UserModel> {
  @override
  Future<Either<String,String>> call({required UserModel params1}) async{
    try {
    final result = await ServiceLocator.sl<AuthRepostory>().signUp(userModel: params1);

    return  result.fold((l) => left(l), (r) => right(r),);
    
  } catch (e) {
    return Left("Unexpected error: ${e.toString()}"); // Catch any other errors
  }
  }
}
