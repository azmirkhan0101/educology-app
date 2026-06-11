
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PercentageCard extends StatelessWidget {
  final String svgPath;
  final String percentage;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const PercentageCard({
    super.key,
    required this.svgPath,
    required this.percentage,
    required this.label,
    this.backgroundColor = const Color(0xFFF1F9F5),
    this.textColor = const Color(0xFF9E8E68),
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                svgPath,
                height: isTab ? 40 : 26,
                width: isTab ? 40 : 26,
              ),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: isTab ? 12.sp : 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTab ? 10.sp : 11,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }
}