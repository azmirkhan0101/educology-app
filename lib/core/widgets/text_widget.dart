import 'package:flutter/material.dart';

import '../assets_gen/fonts.gen.dart';
import '../utils/app_colors.dart';

class TextWidget extends StatelessWidget {

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final FontStyle fontStyle;
  final Color fontColor;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign textAlignment;
  final String? fontFamily;
  final bool underline;
  final Color? underlineColor;
  final double underlineWidth;
  final double figmaLetterSpacing;

  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 18,
    this.fontStyle = FontStyle.normal,
    this.fontColor = AppColors.black,
    this.overflow,
    this.maxLines,
    this.textAlignment = TextAlign.center,
    this.fontFamily = FontFamily.inter,
    this.underline = false,
    this.underlineColor,
    this.underlineWidth = 1.0,
    this.figmaLetterSpacing = 0

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlignment,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
        color: fontColor,
        fontFamily: fontFamily,
        //letterSpacing: letterSpacingFromFigma(figmaLetterSpacing, fontSize),
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: underline ? underlineColor : null,
        decorationThickness: underline ? underlineWidth : null,
      ),
    );
  }
}
