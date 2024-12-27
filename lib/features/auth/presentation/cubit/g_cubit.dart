import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/service_locator.dart';

enum GoogleSignInState { initial, loading, success, failure }

class GoogleSignInCubit extends Cubit<GoogleSignInState> {

  GoogleSignInCubit()
      : super(GoogleSignInState.initial);

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInState.loading);

    try {
await GoogleSignInUsecase().call();    
                    Either<Null, String> result =  ServiceLocator.sl<AuthFirebaseService>().getUserEmailId();

      result.fold(
        (l) {
          emit(GoogleSignInState.failure); 
        },
        (r) {
          emit(GoogleSignInState.success); 
        },
      );
    } catch (e) {
      emit(GoogleSignInState.failure); 
    }
  }
}
