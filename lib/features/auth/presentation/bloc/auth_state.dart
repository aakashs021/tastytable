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
