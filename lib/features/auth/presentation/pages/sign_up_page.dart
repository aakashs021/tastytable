import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/core/utils/validators/password_validators.dart';
import 'package:tastytable/core/utils/validators/user_name_validators.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';
import 'package:tastytable/features/auth/presentation/enum/text_feild_type_enum.dart';
import 'package:tastytable/features/auth/presentation/widgets/bottom_text.dart';
import 'package:tastytable/features/auth/presentation/widgets/image_with_shimmer.dart';
import 'package:tastytable/features/auth/presentation/widgets/text_form_feild.dart';
import 'package:tastytable/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:tastytable/features/auth/presentation/widgets/sign_in_button.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
      var formKey= GlobalKey<FormState>();

   TextEditingController userController=TextEditingController();
    TextEditingController emailController=TextEditingController();
   TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(key: formKey,
              child: ListView(
                children: [
                  const AuthImageWithShimmer(
                      assetImage: AppImages.authSignUpLogoImg),
                  AuthTextformfeild(validator: UsernameValidator.validate, controller: userController, hintText: "User name"),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextformfeild(validator: EmailValidator.validate ,controller: emailController, hintText: "Email"),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextformfeild(validator: PasswordValidator.validate ,controller: passwordController, hintText: "Password",feildtype: AuthTextFormFeildType.password,),
                  const SizedBox(
                    height: 20,
                  ),
                   SignInButton(
                  formKey: formKey,
                  signInOnTap: () => handleSignUp(
                    context: context,
                    email: emailController.text,
                    formkey: formKey,name: "",password: passwordController.text
                  ),
                  userModel: UserModel(
                      name: userController.text,
                      email: emailController.text,
                      password: passwordController.text),
                  pageType: AuthPageType.signup,
                  text: "Sign Up",
                ),
                  const GoogleSignInButton(),
                ],
              ),
            ),
          ),
        )),
        bottomNavigationBar: authBottomText(
            textType: AuthPageType.signup,
            context: context,
            content: 'Alredy have an account?',
            link: 'Sign In'));
  }
}
handleSignUp({required BuildContext context, required String name,required String email, required String password, required GlobalKey<FormState> formkey}){
if(formkey.currentState!.validate()){
    UserModel userModel=UserModel(name: name, email: email, password: password);
    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(userModel: userModel));
  }
}