import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? widthFactor; // Optional width factor (0.0 to 1.0)
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final bool isLoading; // <-- new param

  const CustomButton({
    required this.label,
    this.onPressed,
    this.widthFactor,
    this.margin,
    this.padding,
    this.labelStyle,
    this.isLoading = false, // <-- default false
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Default width based on text, or scaled width if widthFactor is provided
    final double screenWidth = MediaQuery.of(context).size.width;
    final double? buttonWidth = widthFactor != null
        ? screenWidth * widthFactor!
        : null; // Null allows text to determine width

    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes to finger pointer on hover
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth transition for elevation
          width: buttonWidth,
          margin: margin ?? EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          padding: padding ?? EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 9, 65, 162), // Updated blue color
            borderRadius: BorderRadius.circular(4), // Less border radius
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 158, 158, 158), // Slight shadow on hover
                offset: Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: labelStyle ?? TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white, // White text
                  ),
                ),
                if (isLoading)
                  Container(
                    height: 18,
                    width: 18,
                    margin: const EdgeInsets.only(left: 10),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2.2,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}