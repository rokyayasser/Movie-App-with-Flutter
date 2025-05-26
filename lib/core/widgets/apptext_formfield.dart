import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  const AppTextFormField(
      {super.key,
      this.contentPadding,
      this.focusedBorder,
      this.enabledBorder,
      this.inputTextStyle,
      this.hintStyle,
      required this.hintText,
      this.isObscureText,
      this.suffixIcon,
      this.backgroundColor,
      required this.controller,
      this.validator,
      this.keyboardType,
      this.prefixIcon,
      this.borderRadius,
      this.color,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.3),
            borderRadius: borderRadius ??
                BorderRadius.circular(12.0)), //// عشان اعرف اديله بادينج
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.circular(0)),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(color: Color(0xffA8A8A9), width: 1.3),
        //     borderRadius: BorderRadius.circular(12.0)),
        hintStyle: hintStyle ??
            TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color ?? const Color(0xff676767)),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? const Color(0xffF3F3F3),
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
      controller: controller,
      validator: validator,
    );
  }
}
