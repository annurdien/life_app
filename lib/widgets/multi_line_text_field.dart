import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_app/themes/custom_theme.dart';

class MultiLineTextField extends StatelessWidget {
  const MultiLineTextField({
    super.key,
    this.controller,
    this.focusScope,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    required this.hintText,
  });

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusScope;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return TextFormField(
      controller: controller,
      style: context.textTheme.body.withColor(colors.snow),
      maxLines: null,
      minLines: 5,
      decoration: InputDecoration(
        prefix: prefix,
        suffix: suffix,
        labelStyle: textTheme.body.withColor(colors.snow),
        hintText: hintText,
        hintStyle: textTheme.body.withColor(colors.white.withOpacity(0.5)),
        filled: true,
        fillColor: const Color(0xFF1F3757),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.w),
          borderSide: BorderSide(
            color: colors.lipstickPink,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.w),
          borderSide: const BorderSide(
            color: Color(0xFF647872),
          ),
        ),
      ),
    );
  }
}
