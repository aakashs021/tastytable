import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.privacyAndPolicyContainerBackgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 35,
                      color: AppColors.privacyAndPolicyLockIconColor,
                    ),
                    Text(
                      'Privacy and policy',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
                Text(
                    style: TextStyle(fontSize: 17),
                    "Welcome to Tasty Table! Your privacy is crucial to us, and this Privacy Policy outlines the types of personal information we collect, how it's used, and the measures we take to protect your information. By using our app, you consent to the data practices described in this policy.")
                ,
                SizedBox(
                  height: 10,
                ),
                policytext(data: 'Information Collection', fs: 20),
                policytext(
                    data:
                        'Tasty Table collects the following personal information from you when you create an account:'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 7,
                      ),
                    ),
                    ownerDetailText(name: 'Email Address: '),
                    Expanded(
                      child: Container(
                        child: policytext(
                            data:
                                'To contact you for updates, newsletters, and customer service purposes.'),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 7,
                      ),
                    ),
                    ownerDetailText(name: 'Name of user: '),
                    Expanded(
                      child: Container(
                        child: policytext(
                            data: 'To personalize your experience on our app.'),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                policytext(data: 'Sharing of Information', fs: 20),
                policytext(
                    data:
                        'Tasty Table does not sell, rent, or lease your personal information to third parties. Your information may be shared with trusted partners to help perform statistical analysis, send you email or postal mail, provide customer support, or arrange for deliveries. All such third parties are prohibited from using your personal information except to provide these services to Tasty Table, and they are required to maintain the confidentiality of your information.'),
                SizedBox(
                  height: 10,
                ),
                policytext(data: 'Data Security', fs: 20),
                policytext(
                    data:
                        'Recipes Box secures your personal information from unauthorized access, use, or disclosure. We implement a variety of security measures when a user enters, submits, or accesses their information to maintain the safety of your personal data.'),
                SizedBox(
                  height: 10,
                ),
                policytext(
                    data: 'Accessing and Updating Your Personal Information',
                    fs: 20),
                policytext(
                    data:
                        "You can review, update, or delete your personal information through the app's account settings. If you wish to delete your account, you can do so in the app or contact our support team for assistance."),
                SizedBox(
                  height: 10,
                ),
                policytext(data: 'Changes to this Privacy Policy', fs: 20),
                policytext(
                    data:
                        'Tasty Table may update this Privacy Policy to reflect company and customer feedback or changes in data protection laws. We encourage you to periodically review this Policy to be informed of how Tasty Table is protecting your information.'),
                SizedBox(
                  height: 10,
                ),
                policytext(data: 'Contact Information'),
                policytext(
                    data:
                        'Tasty Table welcomes your questions or comments regarding this Privacy Policy. If you believe that Tasty Table has not adhered to this Policy, please contact us at:'),
                Row(
                  children: [
                    policytext(data: 'Email:'),
                    policytext(data: ' aakashs2021sa@gmail.com')
                  ],
                ),
                Row(
                  children: [
                    policytext(data: 'Phone:'),
                    policytext(data: ' +916282711788'),
                  ],
                ),
                policytext(
                    data:
                        'We are committed to ensuring your information is secure and managed with the utmost care. '),
                policytext(data: 'Thank you for choosing Tasty Table!'),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text('Go back')))
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Text policytext(
    {required String data, double fs = 17, }) {
  return Text(
    data,
    style: TextStyle(fontSize: fs, ),
  );
}

Text ownerDetailText(
    {required String name,
    Color colour = Colors.grey,
    double fsize = 15,
    FontWeight fweigth = FontWeight.bold}) {
  return Text(
    name,
    style:
        TextStyle(fontWeight: FontWeight.bold, fontSize: fsize, color: AppColors.privacyAndPolicyOwnerTextColor),
  );
}