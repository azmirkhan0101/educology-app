import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets_gen/assets.gen.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double borderRadius;
  final Color borderColor;
  final bool isPassword;
  final bool readOnly;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool? isDens;
  final String obscureCharacter;

  // 🔹 new parameters for image paths
  final String? prefixIcon;
  final String? suffixIcon;
  final bool isBackgroundTransparent;

  const CustomTextField({
    super.key,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = Colors.black,
    this.inputTextStyle,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.maxLines = 1,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.fillColor = AppColors.white,
    this.borderRadius = 12,
    this.borderColor = Colors.transparent,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLength,
    this.onTap,
    this.isDens = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isBackgroundTransparent = false,
    this.obscureCharacter = '*',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      autovalidateMode: AutovalidateMode.disabled,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly,
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      style: widget.inputTextStyle,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? obscureText : false,
      obscuringCharacter: widget.obscureCharacter,
      validator: widget.validator,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        isDense: widget.isDens,
        errorMaxLines: 2,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        fillColor: widget.fillColor,
        filled: true,

        // 🔹 Prefix Image
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.all(12.w),
                child: SvgPicture.asset(
                  widget.prefixIcon!,
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.contain,
                ),
              )
            : null,

        // 🔹 Suffix Image / Password toggle
        suffixIcon: widget.isPassword && widget.suffixIcon == null
            ? GestureDetector(
                onTap: toggle,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: !widget.isBackgroundTransparent ? SvgPicture.asset(
                    obscureText ? Assets.icons.eye : Assets.icons.eyeHide,
                    width: 10.w,
                    height: 10.h,
                    fit: BoxFit.contain,
                  ) : SvgPicture.asset(
                    obscureText ? Assets.icons.eyeWhite : Assets.icons.eyeHideWhite,
                    width: 10.w,
                    height: 10.h,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : (widget.suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SvgPicture.asset(
                        widget.suffixIcon!,
                        width: 16.w,
                        height: 16.h,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xFFE4E4E4), width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xFFE4E4E4), width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1),
        ),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
