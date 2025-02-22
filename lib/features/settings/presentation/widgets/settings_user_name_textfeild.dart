import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  print(result);

                  // if(result is bool){
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
                    color: Colors.blue, size: 30, Icons.mode_edit_outlined))
            : null,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black)),
      ),
      controller: TextEditingController(
        text: userName,
      ),
    );
  }
}
// Widget SettingUserNameTextFeild({String username = '',required BuildContext context}) {
//   return TextField(
//     enableInteractiveSelection: false,
//     readOnly: true,
//     decoration: InputDecoration(
//       suffixIcon: isName? IconButton(
//           onPressed: () {
//             GoRouter.of(context).pushNamed(AppRouterConstants.editNameRouteName,pathParameters: {'username':username});
//           },
//           icon: Icon(color: Colors.blue, size: 30, Icons.mode_edit_outlined)):null,
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Colors.black)),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Colors.black)),
//     ),
//     controller: TextEditingController(
//       text: username,
//     ),
//   );
// }
