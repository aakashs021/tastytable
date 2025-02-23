import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class AuthRepositoryImpl extends AuthRepostory {
  @override
  Future<Either<String, String>> signIn({required UserModel userModel}) async {
    return await ServiceLocator.sl<AuthFirebaseService>().signIn(userModel);
  }

  @override
  Future<Either<String, String>> signUp({required UserModel userModel}) async {
    return await ServiceLocator.sl<AuthFirebaseService>().signUp(userModel);
  }

  @override
  Either<Null, String> getUser() {
    try {
      Either<Null, String> result =
          ServiceLocator.sl<AuthFirebaseService>().getUserEmailId();
      return result;
    } catch (e) {
      return right('error');
    }
  }

  @override
  Future<Either<String, String>> googleSignIn() async {
    Either<String, String> result =
        await ServiceLocator.sl<AuthFirebaseService>().googleSignIn();
    return result;
  }
  
  @override
  Either<String, String> signOut() {
   return  ServiceLocator.sl<AuthFirebaseService>().signOut();
  }
}
