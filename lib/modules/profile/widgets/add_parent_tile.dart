import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/cached_image_widget.dart';

class AddParentTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isDelete;
  final List<StaffModel?>? parents; // Changed from StaffModel? to List<StaffModel>

  const AddParentTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isDelete = false,
    required this.parents, // Marked as required list
  });

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isDelete ? AppColors.red10Percent : const Color(0xFFF1FDF8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset(iconPath),
                TextWidget(fontSize: isTab ? 10.sp : null, text: title, textAlignment: TextAlign.left),
              ],
            ),
            const Divider(),

            // Dynamic Parent List
            if ( parents != null && parents!.isNotEmpty) ...[
              Column(
                children: parents!.map((parent) {
                  return Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 45.h,
                            width: 45.w,
                            color: AppColors.greyB2,
                            child: CachedImageWidget(
                              imageUrl: parent?.image ?? "",
                              iconSize: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parent?.fullName ?? "",
                                style: TextStyle(
                                  fontSize: isTab ? 10.sp : 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                parent?.contact ?? "",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: isTab ? 10.sp : 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const Divider(), // Divider between the parent list and the action button
            ],

            // Add Action Row
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.add, color: AppColors.secondaryGreen),
                const SizedBox(width: 10),
                TextWidget(
                  text: AppStrings.addYourParent,
                  textAlignment: TextAlign.left,
                  fontSize: isTab ? 8.sp : null,
                  fontColor: AppColors.secondaryGreen,
                ),
                const Spacer(),
                SvgPicture.asset(
                  Assets.icons.rightTriangle,
                  height: isTab ? 40 : null,
                  width: isTab ? 40 : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}