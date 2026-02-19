
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatCardWidget extends StatelessWidget {
  final String svgPath;
  final String percentage;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatCardWidget({
    super.key,
    required this.svgPath,
    required this.percentage,
    required this.label,
    this.backgroundColor = const Color(0xFFF1F9F5), // Light mint green
    this.textColor = const Color(0xFF9E8E68),      // Muted gold/brown
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                svgPath,
                height: 35,
                width: 35,
              ),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 25,
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
              style: const TextStyle(
                fontSize: 12,
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