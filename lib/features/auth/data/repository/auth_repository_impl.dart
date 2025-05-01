import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/service_locator.dart';

class AuthRepositoryImpl extends AuthRepostory {
  static final sl=ServiceLocator.sl<AuthFirebaseService>();

  @override
  Future<Either<String, String>> signIn({required UserModel userModel}) async {
    return await sl.signIn(userModel);
  }

  @override
  Future<Either<String, String>> signUp({required UserModel userModel}) async {
    return await sl.signUp(userModel);
  }

  @override
  Either<Null, String> getUser() {
    try {
      Either<Null, String> result =
          sl.getUserEmailId();
      return result;
    } catch (e) {
      return right('error');
    }
  }

  @override
  Future<Either<String, String>> googleSignIn() async {
    Either<String, String> result =
        await sl.googleSignIn();
    return result;
  }
  
  @override
  Either<String, String> signOut() {
   return  sl.signOut();
  }
  
  @override
  Future<Either<String, String>> forgotPassword({required String email}) async{
    try{

   String result = await sl.forgotPassword(email: email);
    return right(result);
    }
     on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      return left(errorMessage);
    }
    catch(e){
      print(e);
      print('------------------------');
       if (e.toString() == 'Exception: Google users cannot reset password.') {
        return left('Google users cannot reset password. Please use your Google account settings.');
      }
      if(e.toString()== 'Exception: User does not exists'){
        return left('User does not exists!');
      }
      return left(e.toString());
    }
   

  }

  String _getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'user-not-found':
      return 'No user found with this email address.';
    case 'invalid-email':
      return 'The email address is invalid.';
    case 'too-many-requests':
      return 'Too many requests, please try again later.';
    case 'network-error':
      return 'Network error, please check your connection.';
    default:
      return 'Something went wrong, please try again.';
  }
}
}
