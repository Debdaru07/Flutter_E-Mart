import 'dart:developer';

import 'package:flutter/material.dart';
import 'providers/email_subscriber_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/features_screen.dart';
import 'screens/how_it_works_screen.dart';
import 'screens/login_screen.dart';
import 'screens/pricing_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/subscribe_screen.dart';
import 'styles/appstyles.dart';
import 'widgets/button.dart';
import 'widgets/fontStyles.dart';
import 'widgets/navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/textUtils.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationState()),
        ChangeNotifierProvider(create: (_) => EmailSubscriberProvider()),
      ],
      child: const MyWebsite(),
    ),
    // ChangeNotifierProvider(
    //   create: (_) => NavigationState(),
    //   child: MyWebsite()
    // )
  );
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
      home: Consumer<NavigationState>(
        builder: (context, navigationState, child) {
          return Scaffold(
            appBar: const NavigationBarWidget(),
            backgroundColor: Colors.white,
            body: _getScreen(navigationState.selectedScreen),
          );
        },
      ),
    );
  }

  Widget _getScreen(String screen) {
    switch (screen) {
      case '/features':
        return FeaturesScreen();
      case '/how-it-works':
        return HowItWorksScreen();
      case '/pricing':
        return PricingScreen();
      case '/faq':
        return FAQScreen();
      case '/login':
        return LoginScreen();
      case '/subscribe':
        return SubscribeScreen();
      case '/home':
      default:
        return HomePage();
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
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
                const SizedBox(height: 20),
                Text(
                  'NewsForge helps publishers convert legacy PDF content\ninto modern, structured digital articles with AI-powered\nparsing and intuitive editing tools.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                Consumer<NavigationState>(
                  builder: (context, navigationState, child) => 
                  CustomButton(
                    label: 'Join the Waitlist',
                    key: null,
                    widthFactor: 0.28,
                    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    onPressed: () => navigationState.setSelectedScreen('/subscribe'),
                    labelStyle: AppStyles.subtitleStyle.copyWith(color: AppStyles.backgroundColor),
                  ),
                ),
                const SizedBox(height: 10),
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
          Expanded(
            child: Image.asset(
              'assets/landing_page_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}