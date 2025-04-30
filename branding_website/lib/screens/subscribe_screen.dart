import 'package:flutter/material.dart';

import '../styles/appstyles.dart';
import '../widgets/bullet_point.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
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
                      'Join Our Waitlist',
                      style: AppStyles.titleStyle.copyWith(color: AppStyles.backgroundColor, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        'Be the First to Experience the Future of News !',
                        style: AppStyles.titleStyle.copyWith(fontSize: 20), 
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Our platform is revolutionizing how media houses and solo journalists create, share, and monetize content. Join our waitlist to get early access and be part of a growing community of news innovators.',
                        textAlign: TextAlign.center,
                        style: AppStyles.titleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppStyles.textColor), 
                      ),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BulletPoint(text: "Early Access: Be among the first to explore our cutting-edge features and tools."),
                            BulletPoint(text: "Shape the Platform: Provide feedback to help us tailor the platform to your needs."),
                            BulletPoint(text: "Stay Informed: Receive updates on new features, partnerships, and exclusive opportunities."),
                            BulletPoint(text: "Community Benefits: Connect with like-minded professionals and grow your network."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: emailController,
                              hintText: "Enter your email address",
                              borderColor: AppStyles.primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email, color: AppStyles.primaryColor,),
                            ),
                          ),
                          const SizedBox(width: 12),
                          CustomButton(
                            label: 'Subscribe',
                            key: null,
                            widthFactor: 0.225,
                            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            labelStyle: AppStyles.subtitleStyle.copyWith(color: AppStyles.backgroundColor),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
