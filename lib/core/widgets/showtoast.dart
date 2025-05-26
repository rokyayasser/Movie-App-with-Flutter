import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({
  required String message,
  Color backgroundColor = const Color(0xff2662FD),
  Color textColor = Colors.white,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Toast toastLength = Toast.LENGTH_SHORT,
  double backgroundOpacity = 0.75,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    backgroundColor: backgroundColor.withOpacity(backgroundOpacity),
    textColor: textColor,
  );
}
