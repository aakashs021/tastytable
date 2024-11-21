import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';
import 'package:tastytable/features/auth/presentation/widgets/loading_widget.dart';
import 'package:tastytable/features/auth/presentation/widgets/snack_bar.dart';
import 'package:tastytable/router/app_router_constants.dart';

class SignInButton2 extends StatelessWidget {
  final VoidCallback signInOnTap;
  final String text;
  final AuthPageType pageType;
  const SignInButton2({
    super.key,
    required this.signInOnTap,
    required this.text,
    required this.pageType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          authSnackBar(context: context, state: state);
        }
        if (state is AuthSuccess) {
          if (pageType == AuthPageType.signup) {
            context.goNamed(AppRouterConstants.signInRouteName);
          } else if (state.isLogin) {
            context.goNamed(AppRouterConstants.homeRouteName);
          }
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return authLoadingOnButtonClick();
        }
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: AppColors.authSignInButtonBackgroundColor),
            onPressed: signInOnTap,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ));
      },
    );
  }
}
