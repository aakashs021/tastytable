import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_event.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_state.dart';
import 'package:tastytable/router/app_router_constants.dart';

class PasswordCheckPage extends StatefulWidget {
  final String email;
  final String? reason;
  PasswordCheckPage({super.key, required this.email, required this.reason});

  @override
  State<PasswordCheckPage> createState() => _PasswordCheckPageState();
}

class _PasswordCheckPageState extends State<PasswordCheckPage> {
  var formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                enableInteractiveSelection: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Your email ID',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: AppColors.settingsCommonTextFeildBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: AppColors.settingsCommonTextFeildBorderColor)),
                ),
                controller: TextEditingController(
                  text: widget.email,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter you password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: AppColors.settingsCommonTextFeildBorderColor)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              BlocListener<DeleteAccountBloc, DeleteAccountState>(
                listener: (context, state) {
                  if (state is DeleteAccountLoadingState) {
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      backgroundColor: Colors.white, // Clean white background
                      title: Center(
                        child: Text(
                          'Deleting Account',
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
                  if (state is DeleteAccountFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                            title: "Invalid error",
                            message: state.errorText,
                            contentType: ContentType.failure)));
                  }
                  if (state is DeleteAccountSuccessState) {
                    GoRouter.of(context)
                        .goNamed(AppRouterConstants.signInRouteName);
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          QuickAlert.show(
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              context.read<DeleteAccountBloc>().add(
                                  OnDeleteAccountEvent(
                                      password: passwordController.text,
                                      reason: widget.reason));
                            },
                          );
                        }
                      },
                      child: Text(
                          style: TextStyle(fontSize: 18), 'Delete my account')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
