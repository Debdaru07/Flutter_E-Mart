import 'package:flutter/material.dart';

import '../widgets/bullet_point.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.blue[700],
                    child: const Center(
                      child: Text(
                        'Welcome to Our News Platform',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Why Register with Us?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Join our exclusive B2B platform designed for media houses and solo journalists to amplify your reach, streamline your workflow, and connect with a global audience.',
                    textAlign: TextAlign.center,
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
                  ElevatedButton(
                    onPressed: () {
                      // Proceed to login logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                    ),
                    child: const Text('Proceed to Login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}