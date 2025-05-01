import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/usecase/auth/usecase_forgot_password.dart';
import 'package:tastytable/features/auth/domain/usecase/signin_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/signup_usecase.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/service_locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ForgotPasswordSuccessBackButtonEvent>(_onForgotSuccessBackButton);
  }
  _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      Either result = await ServiceLocator.sl<SigninUseCase>()
          .call(params1: event.userModel);
      _handleResult(result, emit, true);
      
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      Either result = await ServiceLocator.sl<SignupUsecase>()
          .call(params1: event.userModel);
      _handleResult(result, emit, false);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  _onForgotPassword(ForgotPasswordEvent event,Emitter<AuthState> emit)async{
    emit(AuthFogotPasswordLoading());
   Either<String, String> result = await ServiceLocator.sl<UsecaseForgotPassword>().call(email: event.email);
   result.fold((l) => emit(AuthForgotPasswordFailure(errorCode: l)), (r) => emit(AuthFogotPasswordSuccess()));
  }

  _onForgotSuccessBackButton(ForgotPasswordSuccessBackButtonEvent event,Emitter<AuthState> emit){
    emit(AuthForgotPasswordInitial());
  }

  _handleResult(Either result, Emitter<AuthState> emit, bool signChecker) {
    result.fold(
      (failure) => emit(AuthError(failure)),
      (success) => emit(AuthSuccess(success, isLogin: signChecker)),
    );
  }
}
