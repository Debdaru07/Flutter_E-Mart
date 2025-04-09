import 'package:flutter/material.dart';
import 'screens/features_screen.dart';
import 'screens/how_it_works_screen.dart';
import 'screens/pricing_screen.dart';
import 'screens/faq_screen.dart';
import 'widgets/navigation_bar.dart';

void main() {
  runApp(MyWebsite());
}

class MyWebsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsForge',
      theme: ThemeData(
        canvasColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/features': (context) => FeaturesScreen(),
        '/how-it-works': (context) => HowItWorksScreen(),
        '/pricing': (context) => PricingScreen(),
        '/faq': (context) => FAQScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationBarWidget(),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transform PDFs\ninto Structured\nDigital News',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'NewsForge helps publishers convert legacy PDF content\ninto modern, structured digital articles with AI-powered\nparsing and intuitive editing tools.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Text('Join the Waitlist'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Early access for qualified publishers. Learn more'),
                  ),
                ],
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: Image.asset(
                'assets/typewriter.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}