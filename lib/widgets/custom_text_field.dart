import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_app/themes/custom_theme.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.focusScope,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusScope;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: textTheme.body.withColor(
              colors.white,
            ),
          ),
          8.verticalSpace,
          TextFormField(
            key: widget.key,
            validator: widget.validator,
            controller: widget.controller,
            focusNode: widget.focusScope,
            obscureText: widget.obscureText,
            style: textTheme.body.withColor(colors.white),
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              prefix: widget.prefix,
              suffix: widget.suffix,
              labelStyle: textTheme.body.withColor(colors.white),
              hintText: widget.hintText,
              hintStyle:
                  textTheme.body.withColor(colors.white.withOpacity(0.5)),
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
          ),
        ],
      ),
    );
  }
}
