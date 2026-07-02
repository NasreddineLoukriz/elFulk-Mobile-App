import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final SvgPicture prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool hasError;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.hasError = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color borderColor =
        widget.hasError ? theme.colorScheme.error : theme.colorScheme.outline;
    final Color focusedBorderColor =
        widget.hasError ? theme.colorScheme.error : theme.colorScheme.primary;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          fontSize: 13.sp,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(context.spacing.m.r),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: SvgPicture.asset(
                  _isObscured
                      ? AssetsPathHelper.eye
                      : AssetsPathHelper.eyeClosed,
                  width: 20.w,
                  height: 20.h,
                ),
                onPressed: () => setState(() => _isObscured = !_isObscured),
              )
            : null,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        contentPadding: EdgeInsets.symmetric(
          vertical: context.spacing.md.h,
          horizontal: context.spacing.md.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.xl.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radius.xl.r),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
      ),
    );
  }
}
