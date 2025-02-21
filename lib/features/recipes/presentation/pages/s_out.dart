import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/domain/usecase/signout_usecase.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/features/auth/presentation/widgets/snack_bar.dart';
import 'package:tastytable/router/app_router_constants.dart';

signOutFunction({required BuildContext context}){
   Either<String, String> result = SignoutUsecase().call();
                    result.fold(
                      (l) =>
                          authSnackBar(context: context, state: AuthError(l)),
                      (r) =>
                          context.goNamed(AppRouterConstants.signInRouteName),
                    );
}