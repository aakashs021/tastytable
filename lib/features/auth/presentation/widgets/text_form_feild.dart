import 'package:flutter/material.dart';
import 'package:tastytable/features/auth/presentation/enum/text_feild_type_enum.dart';

class AuthTextformfeild extends StatefulWidget {
  final Function validator;
  final String hintText;
  final AuthTextFormFeildType? feildtype;
  final TextEditingController controller;
  const AuthTextformfeild({super.key, required this.hintText, this.feildtype, required this.controller, required this.validator});

  @override
  State<AuthTextformfeild> createState() => _AuthTextformfeildState();
}

class _AuthTextformfeildState extends State<AuthTextformfeild> {
  
  bool visibility = true;
 late Function validator;
 late TextEditingController controller;
@override
  void initState() {
    controller=widget.controller;
    validator=widget.validator;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool password = widget.feildtype == AuthTextFormFeildType.password;
    return TextFormField(
      controller: controller,
      validator: (value) {
       return validator(value);
      },
      obscureText: !visibility,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          prefixIcon:
              password ? const Icon(Icons.lock) : const Icon(Icons.email),
          suffixIcon: password
              ? InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                  child: Icon(visibility
                      ? Icons.remove_red_eye_rounded
                      : Icons.visibility_off))
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: widget.hintText),
    );
  }
}
