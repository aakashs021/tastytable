import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/core/utils/validators/password_validators.dart';
import 'package:tastytable/features/auth/domain/usecase/auth_usecase.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';
import 'package:tastytable/features/auth/presentation/enum/text_feild_type_enum.dart';
import 'package:tastytable/features/auth/presentation/widgets/bottom_text.dart';
import 'package:tastytable/features/auth/presentation/widgets/image_with_shimmer.dart';
import 'package:tastytable/features/auth/presentation/widgets/sign_in_button2.dart';
import 'package:tastytable/features/auth/presentation/widgets/text_form_feild.dart';
import 'package:tastytable/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:tastytable/router/app_router_constants.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Don't pop
                child: Text(style: TextStyle(color: Colors.black), 'Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // Pop
                },
                child: Text(style: TextStyle(color: Colors.red), 'Exit'),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () async{
                              final result = await GoRouter.of(context).pushNamed(
                                  AppRouterConstants.forgotPasswordRouteName);
                              print(result);
                              print('--------------------------');
                              if (result == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.transparent,
                                        behavior: SnackBarBehavior.floating,
                                        // margin: EdgeInsets.only(
                                        //     top: 50, left: 20, right: 20),
                                        content: AwesomeSnackbarContent(
                                            title: 'Email sent successfully',
                                            message:
                                                "Please check your email account.",
                                            contentType: ContentType.success)));
                              }
                            },
                            child: Text(
                              'forgot password',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Colors.blue, // Set the underline color

                                  fontWeight: FontWeight.w500),
                            ))),
                  ),
                  SignInButton2(
                    pageType: AuthPageType.signin,
                    signInOnTap: () => AuthUseCase.handleSignIn(
                        context: context,
                        pageType: AuthPageType.signin,
                        email: emailController.text,
                        formkey: formKey,
                        name: "",
                        password: passwordController.text),
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
      ),
    );
  }
}
