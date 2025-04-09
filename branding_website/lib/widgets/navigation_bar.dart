import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavigationBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('NewsForge'),
      actions: [
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
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text('Log in'),
        ),
        SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.blue),
            backgroundColor: Colors.blue,
          ),
          child: Text('Join Waitlist'),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}