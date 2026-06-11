import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/cached_image_widget.dart';

class ParentItemWidget extends StatelessWidget {

  final VoidCallback onPressed;
  final bool isSelected;
  final StaffModel staffModel;
  const ParentItemWidget({super.key, required this.onPressed, required this.isSelected, required this.staffModel});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        color: isSelected ? const Color(0xFFF3FAF6) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: isTab ? 60 : 45.h,
                width: isTab ? 60 : 45.w,
                color: AppColors.greyEB,
                child: CachedImageWidget(
                  imageUrl: staffModel.image,
                  iconSize: 28,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staffModel.fullName,
                  style: TextStyle(
                    fontSize: isTab ? 10.sp : 16,
                    color: isSelected ? const Color(0xFF6BA587) : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                 Text(
                  staffModel.contact,
                  style: TextStyle(color: Colors.grey, fontSize: isTab ? 10.sp : 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
