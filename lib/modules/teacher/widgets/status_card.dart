import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/extensions.dart';

class StatusCard extends StatelessWidget {
  final StudentStatus status;
  final int count;

  const StatusCard({
    super.key,
    required this.status,
    required this.count
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: status.bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: status.primaryColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Your SVG Icon
              SvgPicture.asset(
                status.iconPath,
                width: 28,
              ),
              // Count Number
              Text(
                count.toString().padLeft(2, "0"),
                style: TextStyle(
                  fontSize: isTab ? 16.sp : 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFB08D57),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          //Status Text
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              status.label,
              style: TextStyle(
                fontSize: isTab ? 10.sp : 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5A6166),
              ),
            ),
          ),
        ],
      ),
    );
  }
}