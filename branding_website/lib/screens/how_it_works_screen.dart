import 'package:flutter/material.dart';

import '../constants/appconstants.dart';
import '../providers/navigation_provider.dart';
import '../styles/appstyles.dart';
import 'package:provider/provider.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.howItWorksTitle,
            style: AppStyles.titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.howItWorksDescription,
            style: AppStyles.subtitleStyle,
          ),
          const SizedBox(height: 20),
          _buildStepItem(AppConstants.step1Title, AppConstants.step1Desc),
          _buildStepItem(AppConstants.step2Title, AppConstants.step2Desc),
          _buildStepItem(AppConstants.step3Title, AppConstants.step3Desc),
          const SizedBox(height: 20),
          Consumer<NavigationState>(
            builder: (context, navigationState, child) => ElevatedButton(
              style: AppStyles.buttonStyle,
              onPressed: () => navigationState.setSelectedScreen('/subscribe'),
              child: Text('Join the Waitlist', style: AppStyles.buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.featureTitleStyle),
          const SizedBox(height: 5),
          Text(description, style: AppStyles.featureDescStyle),
        ],
      ),
    );
  }
}