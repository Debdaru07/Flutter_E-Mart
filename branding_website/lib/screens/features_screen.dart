import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Features Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
      ),
    );
  }
}