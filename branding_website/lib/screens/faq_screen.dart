import 'package:flutter/material.dart';

import '../constants/appconstants.dart';
import '../providers/navigation_provider.dart';
import '../styles/appstyles.dart';
import 'package:provider/provider.dart';

import '../widgets/button.dart';


class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.faqTitle,
            style: AppStyles.titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.faqDescription,
            style: AppStyles.subtitleStyle,
          ),
          const SizedBox(height: 20),
          _buildFAQItem(AppConstants.faq1Question, AppConstants.faq1Answer),
          _buildFAQItem(AppConstants.faq2Question, AppConstants.faq2Answer),
          _buildFAQItem(AppConstants.faq3Question, AppConstants.faq3Answer),
          const SizedBox(height: 20),
          Consumer<NavigationState>(
            builder: (context, navigationState, child) =>  CustomButton(
              label: 'Join the Waitlist',
              key: null,
              widthFactor: 0.28,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              onPressed: () => navigationState.setSelectedScreen('/subscribe'),
              labelStyle: AppStyles.subtitleStyle.copyWith(color: AppStyles.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: AppStyles.featureTitleStyle),
          const SizedBox(height: 5),
          Text(answer, style: AppStyles.featureDescStyle),
        ],
      ),
    );
  }
}