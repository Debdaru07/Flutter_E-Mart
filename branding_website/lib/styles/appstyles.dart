import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color primaryColor = Color.fromARGB(255, 9, 65, 162);
  static const Color textColor = Colors.black;
  static const Color secondaryTextColor = Colors.black54;
  static const Color backgroundColor = Colors.white;
  static const Color dividerColor = Color.fromARGB(255, 200, 220, 255);

  static TextStyle get titleStyle => GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      );

  static TextStyle get subtitleStyle => GoogleFonts.poppins(
        fontSize: 16,
        color: secondaryTextColor,
      );

  static TextStyle get featureTitleStyle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      );

  static TextStyle get featureDescStyle => GoogleFonts.poppins(
        fontSize: 14,
        color: secondaryTextColor,
      );

  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: backgroundColor,
      );

  static ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );

  static Divider get customDivider => Divider(
        height: 1,
        thickness: 1,
        color: dividerColor,
      );
}