import 'package:flutter/material.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/core/utils/validators/password_validators.dart';
import 'package:tastytable/core/utils/validators/user_name_validators.dart';
import 'package:tastytable/features/auth/domain/usecase/auth_usecase.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';
import 'package:tastytable/features/auth/presentation/enum/text_feild_type_enum.dart';
import 'package:tastytable/features/auth/presentation/widgets/bottom_text.dart';
import 'package:tastytable/features/auth/presentation/widgets/image_with_shimmer.dart';
import 'package:tastytable/features/auth/presentation/widgets/sign_in_button2.dart';
import 'package:tastytable/features/auth/presentation/widgets/text_form_feild.dart';
import 'package:tastytable/features/auth/presentation/widgets/google_sign_in_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

 final TextEditingController userController = TextEditingController();
 final TextEditingController emailController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();

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
                      assetImage: AppImages.authSignUpLogoImg),
                  AuthTextformfeild(
                      validator: UsernameValidator.validate,
                      controller: userController,
                      hintText: "User name"),
                  const SizedBox(
                    height: 20,
                  ),
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
                  ),SignInButton2(
                        pageType: AuthPageType.signup,
                        signInOnTap: () => AuthUseCase.handleSignIn(
                            context: context,
                            pageType: AuthPageType.signup,
                            email: emailController.text,
                            formkey: formKey,
                            name: userController.text,
                            password: passwordController.text),
                        text: "Sign In",
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
