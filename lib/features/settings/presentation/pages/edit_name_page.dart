import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_event.dart';

class EditNamePage extends StatefulWidget {
  final String userName;
  EditNamePage({super.key, required this.userName});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final TextEditingController controller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change username'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Current Username'),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: widget.userName),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.settingsCommonTextFeildBorderColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.settingsCommonTextFeildBorderColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 30,
              ),
              Text('New UserName'),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Enter your new username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                    width: width * 0.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var result = await quickAlerDialogEditName(
                                context: context,
                                title:
                                    "Are you sure you want to change your name?",
                                newUserName: controller.text);
                            print(result);
                            if (result == true) {
                              GoRouter.of(context).pop(result);
                            }
                          }
                        },
                        child: Text('Edit'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> quickAlerDialogEditName(
    {required BuildContext context,
    required String title,
    required String newUserName}) async {
  bool? isconfirm;
  await QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    text: title,
    onCancelBtnTap: () {
      isconfirm = false;
      context.pop(false);
    },
    onConfirmBtnTap: () {
      context
          .read<UserNameBloc>()
          .add(NameUpdateEvent(newUserName: newUserName));
      isconfirm = true;
      context.pop(true);
    },
  );
  return isconfirm;
}
