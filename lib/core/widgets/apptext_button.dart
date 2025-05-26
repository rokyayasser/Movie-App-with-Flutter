import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.black,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.transparent,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0.5, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                side: BorderSide(color: borderColor ?? Colors.white)),
          ),
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? Colors.black,
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 12,
              vertical: verticalPadding ?? 0,
            ),
          ),
          fixedSize: WidgetStateProperty.all(
            Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 60),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the text horizontally
          children: [
            if (icon != null) Icon(icon, color: iconColor),
            Text(
              buttonText,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
