// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:tastytable/core/configs/theme/app_colors.dart';
// import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
// import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';

// class SignInButton extends StatelessWidget {
//   final VoidCallback signInOnTap;
//   final String text;
//   final AuthPageType pageType;
//  const SignInButton({
//     super.key,
//     required this.signInOnTap,
//     required this.text,
//     required this.pageType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthError) {
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.transparent,
//               content: AwesomeSnackbarContent(
//                   title: "",
//                   message: state.errorMessage,
//                   contentType: ContentType.failure)));
//         } else if (state is AuthSuccess) {
//           print(pageType);
//         }
//       },
//       builder: (context, state) {
//         if (state is AuthLoading) {
//           return const Center(
//             child: SizedBox(
//               width: 50,
//               height: 50,
//               child: LoadingIndicator(
//                 colors: [Colors.black],
//                 strokeWidth: 2,
//                 indicatorType: Indicator.ballPulse,
//               ),
//             ),
//           );
//         }

//         return ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5)),
//                 backgroundColor: AppColors.authSignInButtonBackgroundColor),
//             onPressed: signInOnTap,
//             child: Text(
//               text,
//               style: const TextStyle(color: Colors.white, fontSize: 20),
//             ));
//       },
//     );
//   }
// }
