import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/router/app_router_constants.dart';

class SettingsUserNameTextfeild extends StatelessWidget {
  final String userName;
  SettingsUserNameTextfeild({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    bool isName = userName.isNotEmpty;

    return TextField(
      enableInteractiveSelection: false,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: isName
            ? IconButton(
                onPressed: () async {
                  final result = await GoRouter.of(context).pushNamed(
                      AppRouterConstants.editNameRouteName,
                      pathParameters: {'username': userName});

                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      dismissDirection: DismissDirection.horizontal,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                          title: 'Updated',
                          message: 'Your name is updated.',
                          contentType: ContentType.success),
                    ));
                  }
                },
                icon: Icon(
                    color: AppColors.settingsUserNameIconColor,
                    size: 30,
                    Icons.mode_edit_outlined))
            : null,
       
      ),
      controller: TextEditingController(
        text: userName,
      ),
    );
  }
}
