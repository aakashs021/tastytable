import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/usecase.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class SignupUsecase implements Usecase<Either, UserModel,UserDetailModel> {
  @override
  Future<Either> call({required UserModel params1,required UserDetailModel params2}) async{
    try {
    final results = await Future.wait([
     ServiceLocator.sl<AuthRepostory>().signUp(userModel: params1),
     ServiceLocator.sl<FirestoreRepository>().storeUserDetail(userModel: params2),
    ]);

    final signUpResult = results[0]; 
    final storeResult = results[1];  
    
    // If both operations are successful, return success message
    return signUpResult.fold(
      (signUpError) => Left(signUpError), // If signUp failed, return Left with error
      (_) {
        // Check store result
        return storeResult.fold(
          (storeError) => Left(storeError), // If storing failed, return Left with error
          (_) => const Right("Successfully signed up and stored user data"), // If both succeed, return success
        );
      },
    );
  } catch (e) {
    return Left("Unexpected error: ${e.toString()}"); // Catch any other errors
  }
  }
}
