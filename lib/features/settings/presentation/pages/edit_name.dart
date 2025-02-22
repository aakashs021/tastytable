import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_event.dart';

class EditNamePage extends StatelessWidget {
  final String userName;
  EditNamePage({super.key, required this.userName});
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
                controller: TextEditingController(text: userName),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black)),
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<UserNameBloc>().add(
                                NameUpdateEvent(newUserName: controller.text));
                            GoRouter.of(context).pop(true);
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
