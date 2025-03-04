import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tastytable/features/settings/domain/usecase/get_login_method_usecase.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_text.dart';
import 'package:tastytable/service_locator.dart';

Widget settingsTextAndName(
    {required BuildContext context,
    required String title,
    required String pageName,
    bool Function()? checkLogin}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: GestureDetector(
      onTap: () async {
        if (checkLogin != null) {
          _checkingSignInMethodAlert(context);
          bool check = false;
          check = checkLogin();
          await Future.delayed(Duration(seconds: 1), () => context.pop());
          if (check) {
            bool? procedd = await _changePasswordAlertDialog(context);
            if (procedd == true) {
              var result = await GoRouter.of(context).pushNamed(pageName);
              if (result == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  dismissDirection: DismissDirection.horizontal,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                      title: 'Password Changed',
                      message: 'Your password id changed.',
                      contentType: ContentType.success),
                ));
              }
            }
          } else {
            _showCannotChangePasswordDialog(context);
          }
        } else {
          GoRouter.of(context).pushNamed(pageName);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SettingsText(title: title),
          Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    ),
  );
}

Future<bool?> _changePasswordAlertDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Are you sure?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do you want to change your password?',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop(false); // User pressed No
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Blue text for "No"
            ),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              context.pop(true); // User pressed Yes
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Blue text for "Yes"
            ),
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

_checkingSignInMethodAlert(BuildContext context) async {
  return await showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        backgroundColor: Colors.white, // Clean white background
        title: Center(
          child: Text(
            'Checking Sign In Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        content: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [Colors.grey],
        ),
      );
    },
  );
}

// Custom Android-like alert dialog for "Cannot Change Password"
void _showCannotChangePasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Cannot Change Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'You cannot change the password as you signed in with Google.',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

bool getLoginMethod() {
  Either<bool, bool> result = ServiceLocator.sl<GetLoginMethodUsecase>().call();

  return result.fold(
    (l) => l,
    (r) => r,
  );
}
