import 'package:flutter/material.dart';

import '../styles/appstyles.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  final Color? bulletColor;
  final double? spacing;

  const BulletPoint({
    super.key,
    required this.text,
    this.bulletColor,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing ?? 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '• ',
            style: AppStyles.titleStyle 
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyles.subtitleStyle.copyWith(color: AppStyles.textColor, fontSize: 15)  
            ),
          ),
        ],
      ),
    );
  }
}
