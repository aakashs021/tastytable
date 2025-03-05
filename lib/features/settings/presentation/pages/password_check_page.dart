import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dartz/dartz.dart' as Either;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/settings/domain/usecase/accoun_delete_usecase.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:tastytable/service_locator.dart';

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
                      borderSide: BorderSide(color: AppColors.settingsCommonTextFeildBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.settingsCommonTextFeildBorderColor)),
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
                      borderSide: BorderSide(color: AppColors.settingsCommonTextFeildBorderColor)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
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
                            Either.Either<String, bool> result =
                                await ServiceLocator.sl<AccounDeleteUsecase>()
                                    .call(params1: passwordController.text,params2: widget.reason);
                            result.fold(
                              (l) {
                                context.pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: AwesomeSnackbarContent(
                                            title: "Invalid error",
                                            message: l,
                                            contentType: ContentType.failure)));
                              },
                              (r) {
                                context.pop();
                                GoRouter.of(context).goNamed(
                                    AppRouterConstants.signInRouteName);
                              },
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                        style: TextStyle(fontSize: 18), 'Delete my account')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
