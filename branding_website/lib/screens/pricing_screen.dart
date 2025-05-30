import 'package:flutter/material.dart';

import '../constants/appconstants.dart';
import '../providers/navigation_provider.dart';
import '../styles/appstyles.dart';
import 'package:provider/provider.dart';

import '../widgets/button.dart';


class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.pricingTitle,
            style: AppStyles.titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.pricingDescription,
            style: AppStyles.subtitleStyle,
          ),
          const SizedBox(height: 20),
          _buildPlanItem(AppConstants.plan1Title, AppConstants.plan1Desc, AppConstants.plan1Price),
          _buildPlanItem(AppConstants.plan2Title, AppConstants.plan2Desc, AppConstants.plan2Price),
          _buildPlanItem(AppConstants.plan3Title, AppConstants.plan3Desc, AppConstants.plan3Price),
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

  Widget _buildPlanItem(String title, String description, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.featureTitleStyle),
          const SizedBox(height: 5),
          Text(description, style: AppStyles.featureDescStyle),
          Text(price, style: AppStyles.featureTitleStyle),
        ],
      ),
    );
  }
}