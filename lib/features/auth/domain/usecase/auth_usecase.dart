import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';

class AuthUseCase {

  static handleSignIn({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required AuthPageType pageType,
    required GlobalKey<FormState> formkey,
  }) {
    if (formkey.currentState?.validate() ?? false) {
      final userModel = UserModel(name: name, email: email, password: password);
      final event = pageType == AuthPageType.signin 
          ? SignInEvent(userModel: userModel) 
          : SignUpEvent(userModel: userModel);

  final AuthBloc authBloc =  BlocProvider.of<AuthBloc>(context);
      authBloc.add(event);
    }
  }
}
