import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/features/auth/presentation/cubit/g_cubit.dart';
import 'package:tastytable/features/auth/presentation/widgets/snack_bar.dart';
import 'package:tastytable/router/app_router_constants.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Expanded(child: Divider()),
            SizedBox(
              width: 10,
            ),
            Text('or'),
            SizedBox(
              width: 10,
            ),
            Expanded(child: Divider())
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BlocListener<GoogleSignInCubit, GoogleSignInState>(
          listener: (context, state) {
            if (state == GoogleSignInState.loading) {
              showLoadingDialog(context);
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return const AlertDialog(
              //       backgroundColor: Colors.transparent,
              //       content: SizedBox(
              //         width: 50,
              //         height: 100,
              //         child: LoadingIndicator(
              //           colors: [Colors.white],
              //           indicatorType: Indicator.ballPulse,
              //           backgroundColor: Colors.transparent,
              //         ),
              //       ),
              //     );
              //   },
              // );
            }
            if (state == GoogleSignInState.success) {
              context.goNamed(AppRouterConstants.homeRouteName);
            }
            if (state == GoogleSignInState.failure) {
              context.pop();
              authSnackBar(
                  context: context,
                  state: AuthError("Google signing unsuccessfull"));
            }
          },
          child: SignInButton(Buttons.google, onPressed: () async {
            context.read<GoogleSignInCubit>().signInWithGoogle();
          },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        )
      ],
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const Center(
        child: SizedBox(
          width: 200,
          height: 50,
          child: LoadingIndicator(
            colors: [Colors.white],
            indicatorType: Indicator.ballPulse,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    },
  );
}
