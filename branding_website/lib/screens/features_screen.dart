import 'package:flutter/material.dart';

import '../constants/appconstants.dart';
import '../providers/navigation_provider.dart';
import '../styles/appstyles.dart';
import 'package:provider/provider.dart';

import '../widgets/button.dart';


class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.featuresTitle,
            style: AppStyles.titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.featuresDescription,
            style: AppStyles.subtitleStyle,
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(AppConstants.feature1Title, AppConstants.feature1Desc),
          _buildFeatureItem(AppConstants.feature2Title, AppConstants.feature2Desc),
          _buildFeatureItem(AppConstants.feature3Title, AppConstants.feature3Desc),
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

  Widget _buildFeatureItem(String title, String description) {
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