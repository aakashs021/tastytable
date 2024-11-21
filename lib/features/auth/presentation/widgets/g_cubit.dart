import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

enum GoogleSignInState { initial, loading, success, failure }

class GoogleSignInCubit extends Cubit<GoogleSignInState> {

  GoogleSignInCubit()
      : super(GoogleSignInState.initial);

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInState.loading);

    try {
await GoogleSignInUsecase().call();    
          Either<String, UserModel> result = await GetUserUsecase().call();


      result.fold(
        (l) {
          emit(GoogleSignInState.failure); // Handle error
        },
        (r) {
          emit(GoogleSignInState.success); // Handle success
        },
      );
    } catch (e) {
      emit(GoogleSignInState.failure); // Handle error
    }
  }
}
