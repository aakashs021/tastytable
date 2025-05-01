import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/settings/domain/usecase/delete_google_account_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/get_login_method_usecase.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_event.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_state.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:tastytable/service_locator.dart';

class DeleteAccountConfirmPage extends StatelessWidget {
  final String? reason;
  DeleteAccountConfirmPage({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    'Are you sure you want to delete your account?'),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Your account associated with ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                                TextSpan(
                                  text: email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                TextSpan(
                                  text: ' will be deleted from ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                                TextSpan(
                                  text: 'Tasty Table',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                    style: TextStyle(
                      fontSize: 16,
                      // color: Colors.grey.shade900
                    ),
                    "By submitting a request for Tasty Table to delete your account, you understand and acknowledge that:"),
                Column(
                  children: [
                    deleteConfirmPoints(
                        title:
                            'Deleting your account will revoke your authentication credentials, meaning you will no longer be able to log in to TastyTable.',
                        index: 1),
                    deleteConfirmPoints(
                        title:
                            'All the recipes you have saved and your search history will be permanently deleted. Once your account is deleted, these cannot be recovered.',
                        index: 2),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              color: AppColors.deleteConfirmAccountBottomContainerColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                      'By clicking "Delete my account" below. I acknowledge that I have read and understand that above and that I wish to delete my account.'),
                  SizedBox(
                    height: 20,
                  ),
                  BlocListener<DeleteGoogleAccountBloc,
                      DeleteGoogleAccountState>(
                    listener: (context, state) {
                      if (state is DeleteGoogleAccountLoadingState) {
                         AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      backgroundColor: Colors.white, // Clean white background
                      title: Center(
                        child: Text(
                          'Deleting your account...',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      content: LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader,
                        colors: [Colors.grey],
                      ),
                    );
                      }

                      if (state is DeleteGoogleAccountFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AwesomeSnackbarContent(
                                title: "Invalid error",
                                message: 'error',
                                contentType: ContentType.failure)));
                      }

                      if (state is DeleteGoogleAccountSuccessState) {
                        GoogleSignIn().signOut();
                        GoRouter.of(context)
                            .goNamed(AppRouterConstants.signInRouteName);
                      }
                      if (state is CheckGoogleAccountFailureState) {
                        GoRouter.of(context).pushNamed(
                            AppRouterConstants.checkPasswordPageRouteName,
                            pathParameters: {
                              'email': email,
                            },
                            extra: reason);
                      }

                      if (state is CheckGoogleAccountSuccessState) {
                        QuickAlert.show(
                          // backgroundColor: AppColors.primary,
                          confirmBtnColor: Colors.red,
                          confirmBtnText: 'Delete',
                          context: context,
                          type: QuickAlertType.confirm,
                          title: "Delete Account",
                          text:
                              'Deleting your account will remove all of your information from our database. This cannot be undone.',
                          onCancelBtnTap: () => context.pop(),
                          onConfirmBtnTap: () async {
                            context.pop();
                            context.read<DeleteGoogleAccountBloc>().add(
                                OnDeleteGoolgleAccountEvent(reason: reason));
                          },
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            context
                                .read<DeleteGoogleAccountBloc>()
                                .add(OnCheckGoogleLoginEvent());
                          },
                          child: Text(
                              style: TextStyle(fontSize: 18),
                              'Delete my account')),
                    ),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget deleteConfirmPoints({required String title, required int index}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15.0),
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor:
              AppColors.deleteConfirmAccountCircleAvatarBackgroundColor,
          foregroundColor:
              AppColors.deleteConfirmAccountCircleAvatarForegroundColor,
          radius: 15,
          child: Align(
            // alignment: Alignment.topCenter,
            child: Text(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                index.toString()),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(child: Text(title)),
      ],
    ),
  );
}
