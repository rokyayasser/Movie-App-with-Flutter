import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final double height;
  final double indent;
  final double endIndent;
  final List<Color> colors;

  const GradientDivider({
    super.key,
    this.height = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: indent, right: endIndent),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
