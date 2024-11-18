import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback signInOnTap;
  final UserModel userModel;
  final GlobalKey<FormState> formKey;
  final String text;
  final AuthPageType pageType;
  const SignInButton(
      {super.key,
      required this.signInOnTap,
      required this.userModel,
      required this.text,
      required this.pageType,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: AppColors.AuthSignInButtonBackgroundColor),
        onPressed: 
          signInOnTap,
          // print(userModel.password);
          // if (formKey.currentState!.validate()) {
          //   BlocProvider.of<AuthBloc>(context).add(SignInEvent(userModel: userModel));
          // }
        
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
  }
}
