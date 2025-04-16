import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextUtils {
  static Widget richText(String mainText, {List<InlineSpan>? textSpanList}) {
    List<InlineSpan> children = [];

    // Add the main text as a non-interactive TextSpan
    children.add(
      TextSpan(
        text: mainText,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black54,
        ),
      ),
    );

    // Process the textSpanList if provided
    if (textSpanList != null) {
      for (var span in textSpanList) {
        children.add(span);
      }
    }

    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }

  // Helper widget to wrap interactive TextSpan with InkWell
  static Widget interactiveTextSpan({
    required String text,
    required VoidCallback onTap,
    TextStyle? style,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: text,
            style: style ?? GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}