import 'package:flutter/material.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'How It Works Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
      ),
    );
  }
}