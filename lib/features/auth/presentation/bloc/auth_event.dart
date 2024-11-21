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