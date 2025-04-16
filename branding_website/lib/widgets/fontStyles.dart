import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextStyles {

  static Widget newsForgeHeader(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        letterSpacing: 0.75,
        fontSize: 28,
        fontWeight: FontWeight.w900, 
        color: const Color.fromARGB(255, 9, 65, 162),
      ),
    );
  }

  static Widget mainContentItem(String topText, String bottomText) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: topText,
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
              height: 1.2,
            ),
          ),
          TextSpan(
            text: bottomText,
            style: GoogleFonts.poppins(
              fontSize: 40, // Different font size
              fontWeight: FontWeight.bold, // Different weight
              color: Colors.blueAccent, // Different color
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
