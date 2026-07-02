import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class PasswordRequirements extends StatefulWidget {

  final bool isEightCharacters;
  final bool isBothCasesPresent;
  final bool isNumeralPresent;
  final bool isSpecialCharPresent;
  const PasswordRequirements({
    super.key,
    required this.isEightCharacters,
    required this.isBothCasesPresent,
    required this.isNumeralPresent,
    required this.isSpecialCharPresent
  });

  @override
  State<PasswordRequirements> createState() => _PasswordRequirementsState();
}

class _PasswordRequirementsState extends State<PasswordRequirements> {
  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryGold.withValues(alpha: 0.1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Icon(Icons.info_outline, color: AppColors.primaryGold,),
              TextWidget(
                text: "Password must contain:",
                fontWeight: FontWeight.w400,
                fontSize: isTab ? 12.sp : 14.sp,
                fontColor: AppColors.grey4E,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildRequirementItem( "At least 8 characters", widget.isEightCharacters),
          _buildRequirementItem( "At least one uppercase and one lowercase letter", widget.isBothCasesPresent),
          _buildRequirementItem( "At least one numeral", widget.isNumeralPresent),
          _buildRequirementItem( "At least one special character", widget.isSpecialCharPresent),
        ],
      ),
    );
  }

  // ✅ Pass a bool to control color
  Widget _buildRequirementItem(String text, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          if( isChecked )
            Icon(
              Icons.check_circle_rounded,
              color: AppColors.primaryGold,
            ),
          if( !isChecked )
            Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.primaryGold,
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text,
              style: TextStyle(fontSize: context.isTab ? 10.sp : 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}

