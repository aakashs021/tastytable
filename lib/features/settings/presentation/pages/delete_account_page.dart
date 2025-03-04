import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/router/app_router_constants.dart';

class DeleteAccountPage extends StatefulWidget {
  DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController reasonController = TextEditingController();
  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'We are sorry to see you go. To help us improve and better serve our users, please consider sharing your reason for deleting your account. This step is entirely optional, but your feedback is valuable to us in making improvements. Thank you for taking the time to provide us with your insights.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: reasonController,
                minLines: 10,
                maxLines: 18,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'Please describe your reason (Optional)'),
              ),  
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.deleteAccountContinueButtonBackgroundColor,
                foregroundColor: AppColors.deleteAccountContinueButtonForegroundColor,
              ),
              onPressed: () {
                if (reasonController.text.isEmpty) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    title: null,
                    text:
                        'Are you sure you want to continue without giving the reason?',
                    onCancelBtnTap: () => context.pop(),
                    onConfirmBtnTap: () {
                      context.pop();
                      GoRouter.of(context).pushNamed(
                          AppRouterConstants.deleteAccountConfirmPageRouteName,
                          extra: reasonController.text);
                    },
                  );
                } else {
                  GoRouter.of(context).pushNamed(
                      AppRouterConstants.deleteAccountConfirmPageRouteName,
                      extra: reasonController.text);
                }
              },
              child: Text('Continue')),
        ),
      ),
    );
  }
}
