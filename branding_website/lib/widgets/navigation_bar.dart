import 'dart:developer';

import 'package:flutter/material.dart';

import 'button.dart';
import 'fontStyles.dart';

class NavigationBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavigationBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1); // Adjusted height to account for divider

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          actions: [
            SizedBox(width: 15),
            AppTextStyles.newsForgeHeader('NewsForge'),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/features');
              },
              child: Text('Features', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/how-it-works');
              },
              child: Text('How It Works', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pricing');
              },
              child: Text('Pricing', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/faq');
              },
              child: Text('FAQ', style: TextStyle(color: Colors.black)),
            ),
            Spacer(),
            SizedBox(width: 10),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => log('shift'),
                child: Text('Log in'),
              ),
            ),
            SizedBox(width: 10),
            CustomButton(label: 'Join Waitlist', key: key),
            SizedBox(width: 10),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}