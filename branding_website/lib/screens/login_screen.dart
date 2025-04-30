import 'package:branding_website/styles/appstyles.dart';
import 'package:flutter/material.dart';

import '../widgets/bullet_point.dart';
import '../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            color: AppStyles.backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)
                    )
                  ),
                  child: Center(
                    child: Text(
                      'Welcome to Our News Platform',
                      style: AppStyles.titleStyle.copyWith(color: AppStyles.backgroundColor, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        'Why Register with Us?',
                        style: AppStyles.titleStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Join our exclusive B2B platform designed for media houses and solo journalists to amplify your reach, streamline your workflow, and connect with a global audience.',
                        textAlign: TextAlign.center,
                        style: AppStyles.titleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppStyles.textColor)
                      ),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BulletPoint(text: "Access Premium Tools: Utilize advanced analytics and content management tools to enhance your reporting."),
                            BulletPoint(text: "Network with Peers: Collaborate with other journalists and media professionals in a secure environment."),
                            BulletPoint(text: "Exclusive Content: Gain access to curated news feeds and resources tailored for professionals."),
                            BulletPoint(text: "Boost Visibility: Showcase your work to a wider audience through our platform’s distribution channels."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: 'Proceed to Login',
                        key: null,
                        widthFactor: 0.225,
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        labelStyle: AppStyles.subtitleStyle.copyWith(color: AppStyles.backgroundColor),
                        onPressed: () {},
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}