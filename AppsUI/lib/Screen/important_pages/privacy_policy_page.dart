import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.deepBlue,
        title: const Text('Privacy Policy'),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'This is where you describe your privacy policy. '
              'Include information about what data you collect, how '
              'it is used, and how it is protected.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'For example:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We collect information you provide directly to us, '
              'such as when you create or modify your account, '
              'request on-demand services, contact customer support, '
              'or otherwise communicate with us. This information may '
              'include: name, email, phone number, postal address, '
              'profile picture, payment method, and other information you choose to provide.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Remember to tailor this page to your app\'s specific data '
              'collection and usage practices, and ensure that it complies '
              'with relevant privacy laws and regulations.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
