import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Expanded(child: Divider()),
            SizedBox(
              width: 10,
            ),
            Text('or'),
            SizedBox(
              width: 10,
            ),
            Expanded(child: Divider())
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SignInButton(Buttons.google,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
      ],
    );
  }
}
