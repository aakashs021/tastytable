import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final UserModel userModel;

  SignUpEvent({required this.userModel});
}

class SignInEvent extends AuthEvent{
  final UserModel userModel;

  SignInEvent({required this.userModel});

}

class ForgotPasswordSuccessBackButtonEvent extends AuthEvent{}

class ForgotPasswordEvent extends AuthEvent{
  final String email;

  ForgotPasswordEvent({required this.email});
}