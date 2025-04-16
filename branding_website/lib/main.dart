import 'dart:developer';

import 'package:flutter/material.dart';
import 'screens/features_screen.dart';
import 'screens/how_it_works_screen.dart';
import 'screens/pricing_screen.dart';
import 'screens/faq_screen.dart';
import 'widgets/button.dart';
import 'widgets/fontStyles.dart';
import 'widgets/navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/textUtils.dart';


void main() {
  runApp(MyWebsite());
}

class MyWebsite extends StatelessWidget {
  const MyWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsForge',
      debugShowCheckedModeBanner: false,
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
  const HomePage({super.key});

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
                  AppTextStyles.mainContentItem('Transform PDFs \ninto', ' Structured\nDigital News'),
                  SizedBox(height: 20),
                  Text(
                    'NewsForge helps publishers convert legacy PDF content\ninto modern, structured digital articles with AI-powered\nparsing and intuitive editing tools.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    label: 'Join the Waitlist', 
                    key: key, 
                    widthFactor: 0.28,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  SizedBox(height: 10),
                  TextUtils.richText(
                    'Early access for qualified publishers. ',
                    textSpanList: [
                      WidgetSpan(
                        child: TextUtils.interactiveTextSpan(
                          text: 'Learn more',
                          onTap: () {
                            log('Second part clicked!');
                          },
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 9, 65, 162),
                          ),
                        ),
                      ),
                    ],
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