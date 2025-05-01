import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/assets/app_images.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/core/utils/validators/password_validators.dart';
import 'package:tastytable/features/auth/domain/usecase/auth_usecase.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';
import 'package:tastytable/features/auth/presentation/enum/text_feild_type_enum.dart';
import 'package:tastytable/features/auth/presentation/widgets/bottom_text.dart';
import 'package:tastytable/features/auth/presentation/widgets/image_with_shimmer.dart';
import 'package:tastytable/features/auth/presentation/widgets/sign_in_button2.dart';
import 'package:tastytable/features/auth/presentation/widgets/text_form_feild.dart';
import 'package:tastytable/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:tastytable/features/detail/presentation/widgets/vertical_divider_container.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:url_launcher/url_launcher.dart';

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

// showForgotPasswordBottomSheet({required BuildContext context}) {
//   final TextEditingController controller = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (context) {
//       double h = MediaQuery.of(context).size.height;
//       return BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {
          // if (state is AuthForgotPasswordFailure) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       behavior: SnackBarBehavior.floating,
          //       margin: EdgeInsets.only(
          //           top: 50, left: 20, right: 20), // Adjust top padding
          //       content: AwesomeSnackbarContent(
          //           title: 'Error Occured',
          //           message: state.errorCode,
          //           contentType: ContentType.failure)));
          // }
//         },
//         builder: (context, state) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//             ),
//             height: h * 0.65,
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                   width: 40,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: AppColors.detailVerticalDividerContainer,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 state is AuthFogotPasswordSuccess
//                     ? Align(
//                         alignment: Alignment.topLeft,
//                         child: IconButton(
//                             onPressed: () {
                              // context
                              //     .read<AuthBloc>()
                              //     .add(ForgotPasswordSuccessBackButtonEvent());
//                             },
//                             icon: Icon(Icons.chevron_left_outlined)),
//                       )
//                     : SizedBox(),
//                 Text(
//                   state is AuthFogotPasswordSuccess
//                       ? 'If you want to open the Gmail app click the button below to open'
//                       : 'Forgot Password?\nPlease enter your email address below. A reset link will be sent to your email to help you reset your password.',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                   textAlign: TextAlign.center,
//                 ),
//                 if (state is! AuthFogotPasswordSuccess) ...[
//                   SizedBox(height: 20),
//                   Form(
//                     key: formKey,
//                     child: TextFormField(
//                       controller: controller,
//                       validator: (value) {
//                         return EmailValidator.validate(value ?? "");
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       context
//                           .read<AuthBloc>()
//                           .add(ForgotPasswordEvent(email: controller.text));
//                     }
//                   },
//                   child: state is AuthFogotPasswordLoading
//                       ? CircularProgressIndicator()
//                       : Text(state is AuthFogotPasswordSuccess
//                           ? 'Email'
//                           : 'Send link'),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
