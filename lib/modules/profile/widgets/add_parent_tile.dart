import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/widgets/cached_image_widget.dart';

class AddParentTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isDelete;
  final List<String> parents;

  const AddParentTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isDelete = false,
    required this.parents
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isDelete ? AppColors.red10Percent : const Color(0xFFF1FDF8), // Light mint background
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
          children: [
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset( iconPath ),
                TextWidget(text: title, textAlignment: TextAlign.left,),
              ],
            ),
            Divider(),
            if( parents.isNotEmpty )
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: parents.length,
                itemBuilder: (context, index){
              return Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 45.h,
                        width: 45.w,
                        color: AppColors.greyB2,
                        child: CachedImageWidget(
                          imageUrl: Dummy.profileImageUrl,
                          iconSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parent name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '+8801827347685',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.add, color: AppColors.secondaryGreen,),
                SizedBox(width: 10,),
                TextWidget(text: AppStrings.addYourParent, textAlignment: TextAlign.left, fontColor: AppColors.secondaryGreen,),
                Spacer(),
                SvgPicture.asset(Assets.icons.rightTriangle),
              ],
            ),
          ],
        )
      ),
    );
  }
}