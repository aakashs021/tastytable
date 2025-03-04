import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tastytable/features/settings/data/model/change_password_error_message_model.dart';
import 'package:tastytable/features/settings/domain/usecase/check_password_and_update_usecase.dart';
import 'package:tastytable/features/settings/presentation/cubit/change_password_cubit.dart';
import 'package:tastytable/service_locator.dart';

class EditPasswordPage extends StatelessWidget {
  EditPasswordPage({super.key});
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              passwordText(title: 'Current Password'),
              TextFormField(
                controller: currentPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your current password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your current password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              passwordText(title: 'New Password'),
              TextFormField(
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your new password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              passwordText(title: 'Confirm Password'),
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password again to confirm!";
                  }
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Confirm your new password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String currentPassword =
                              currentPasswordController.text;
                          String newPassword = newPasswordController.text;
                          context.read<ChangePasswordCubit>().onConfirm(
                              currentPassword: currentPassword,
                              newPassword: newPassword);
                        }
                      },
                      child: BlocConsumer<ChangePasswordCubit,
                          ChangePasswordState>(
                        builder: (context, state) {
                          if (state is ChangePasswordStateLoading) {
                            return SizedBox(
                              height: 35,
                              width: 35,
                              child: LoadingIndicator(
                                  colors: [Colors.white],
                                  indicatorType: Indicator.ballPulse),
                            );
                          }
                          return Text('Confirm');
                        },
                        listener: (context, state) {
                          if (state is ChangePasswordStateFailure) {
                            ChangePasswordErrorMessageModel model = state.model;

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                  messageTextStyle: TextStyle(),
                                  // titleTextStyle: TextStyle(fontSize: 15),
                                  title: model.title,
                                  message: model.message,
                                  contentType: ContentType.failure),
                            ));
                          }
                          if (state is ChangePasswordStateSuccess) {
                            GoRouter.of(context).pop(true);
                          }
                        },
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget passwordText({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Text(title),
  );
}
