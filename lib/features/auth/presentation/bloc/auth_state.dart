// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  bool isLogin =false;

  AuthSuccess(this.message,{this.isLogin=false});
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

class AuthForgotPasswordInitial extends AuthState{}

class AuthForgotPasswordFailure extends AuthState {
  String errorCode;
  AuthForgotPasswordFailure({
    required this.errorCode,
  });
}

class AuthFogotPasswordSuccess extends AuthState{}

class AuthFogotPasswordLoading extends AuthState{}