import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final double prefixIconSize;
  final Color prefixIconColor;
  final IconData? icon;
  final double? iconHeight;
  final double? iconWidth;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;
  final double buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? padding;
  final double buttonRadius;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final double? iconSize;
  final double borderWidth;

  // Added Gradient Property
  final Gradient? gradient;

  const ButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.prefixIcon,
    this.prefixIconSize = 20,
    this.prefixIconColor = AppColors.white,
    this.iconHeight,
    this.iconWidth,
    this.textColor = AppColors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.onPressed,
    this.buttonHeight = 56,
    this.buttonWidth,
    this.padding,
    this.buttonRadius = 100,
    this.backgroundColor = AppColors.primaryGold,
    this.borderColor,
    this.iconColor,
    this.iconSize,
    this.borderWidth = 0,
    this.gradient, // Initialize here
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight.h,
      width: buttonWidth?.w,
      decoration: BoxDecoration(
        // Apply gradient if provided, otherwise use backgroundColor
        gradient: gradient,
        color: gradient == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(buttonRadius.r),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth.r)
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          // We make the button background transparent to show the Container's decoration
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius.r),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Icon(prefixIcon, color: prefixIconColor, size: prefixIconSize.r),
            if (prefixIcon != null) SizedBox(width: 12.w),
            TextWidget(
              text: label,
              fontColor: textColor,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
            ),
            if (icon != null) const SizedBox(width: 12),
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? textColor,
                size: iconSize ?? fontSize,
              ),
          ],
        ),
      ),
    );
  }
}
