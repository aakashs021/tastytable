import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/presentation/enum/auth_page_type_enum.dart';

Widget authBottomText(
    {required BuildContext context,
    required String content,
    required String link,
    required AuthPageType textType}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          content,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            if (textType == AuthPageType.signin) {
              context.push('/signup');
            } else {
              // context.go('/signin');
              GoRouter.of(context).replace('/signin');
            }
          },
          child: Text(
            link,
            style: const TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
