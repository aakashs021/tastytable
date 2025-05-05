import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tastytable/core/utils/validators/email_validators.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_event.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController controller = TextEditingController();
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Fogot Password?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'Please enter your email address below. A reset link will be sent to your email to help you reset your password.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  return EmailValidator.validate(value ?? "");
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthForgotPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.transparent,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                            top: 50, left: 20, right: 20), // Adjust top padding
                        content: AwesomeSnackbarContent(
                            title: 'Error Occured',
                            message: state.errorCode,
                            contentType: ContentType.failure)));
                  }
                  if (state is AuthFogotPasswordSuccess) {
                    context.pop(true);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(ForgotPasswordEvent(email: controller.text));
                      },
                      child: state is AuthFogotPasswordLoading
                          ? SizedBox(
                              width: 65,
                              height: 20,
                              child: LoadingIndicator(
                                  colors: [Colors.white],
                                  indicatorType: Indicator.ballBeat))
                          : Text('Sent email'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
