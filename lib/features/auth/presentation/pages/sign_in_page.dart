import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/core/utils/validators/password_validators.dart';
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

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signInOnTap() {
    print(emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const AuthImageWithShimmer(
                    assetImage: AppImages.authSignInLogoImg),
                AuthTextformfeild(
                    validator: EmailValidator.validate,
                    controller: emailController,
                    hintText: "Email"),
                const SizedBox(
                  height: 20,
                ),
                AuthTextformfeild(
                  validator: PasswordValidator.validate,
                  controller: passwordController,
                  hintText: "Password",
                  feildtype: AuthTextFormFeildType.password,
                ),
                const SizedBox(
                  height: 20,
                ),
                SignInButton(
                  formKey: formKey,
                  signInOnTap: () => handleSignIn(
                    context: context,
                    email: emailController.text,
                    formkey: formKey,name: "",password: passwordController.text
                  ),
                  userModel: UserModel(
                      name: "",
                      email: emailController.text,
                      password: passwordController.text),
                  pageType: AuthPageType.signin,
                  text: "Login",
                ),
                const GoogleSignInButton(),
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: authBottomText(
          textType: AuthPageType.signin,
          context: context,
          content: 'Not a member?',
          link: 'Register Now'),
    );
  }
}

handleSignIn({required BuildContext context, required String name,required String email, required String password, required GlobalKey<FormState> formkey}) {
  if(formkey.currentState!.validate()){
    UserModel userModel=UserModel(name: name, email: email, password: password);
    BlocProvider.of<AuthBloc>(context).add(SignInEvent(userModel: userModel));
  }
}

