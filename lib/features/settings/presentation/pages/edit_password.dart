import 'package:flutter/material.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            passwordText(title: 'Current Password'),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter your current password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            passwordText(title: 'New Password'),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            passwordText(title: 'Confirm Password'),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Confirm your new password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: Text('Confirm')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget passwordText({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Text(title),
  );
}
