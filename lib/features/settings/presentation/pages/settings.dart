import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/recipes/presentation/pages/s_out.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_event.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_text.dart';
import 'package:tastytable/features/settings/presentation/widgets/settings_text_and_name.dart';
import 'package:tastytable/features/settings/presentation/widgets/show_user_name.dart';
import 'package:tastytable/features/settings/presentation/widgets/version_number.dart';
import 'package:tastytable/router/app_router_constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserNameBloc>().add(ShowNameEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SettingsText(title: 'Settings'),
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('username'),
                  )),
              showUserName(),
              SizedBox(
                height: 25,
              ),
              settingsTextAndName(
                  context: context,
                  title: 'Change Password',
                  pageName: AppRouterConstants.editPasswordRouteName,
                  checkLogin: getLoginMethod
                  ),
              SizedBox(
                height: 25,
              ),
              settingsTextAndName(
                  context: context,
                  title: 'Privacy & Policy',
                  pageName: AppRouterConstants.privacyAndPolicyRouteName),
              SizedBox(
                height: 25,
              ),
              versionNumber(),
              Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      signOutFunction(context: context);
                    },
                    child: const Text('signout')),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
