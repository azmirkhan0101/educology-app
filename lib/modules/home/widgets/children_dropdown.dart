import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/cached_image_widget.dart';

class ChildrenDropdown extends StatelessWidget {

  final List<StaffModel> children;
  final StaffModel? selectedChild;
  final Function(StaffModel) onItemSelected;

  const ChildrenDropdown({
    super.key,
    required this.children,
    required this.selectedChild,
    required this.onItemSelected
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x199E9E9E),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<StaffModel>(
                      dropdownColor: Colors.white,
                      value: selectedChild,
                      hint: Text("Select Learner"),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black40Percent,
                        fontSize: 14,
                      ),
                      onChanged: (StaffModel? newValue) {
                        if( newValue != null ){
                          onItemSelected( newValue );
                        }
                      },
                      items:
                      children.map<DropdownMenuItem<StaffModel>>((StaffModel child) {
                        return DropdownMenuItem<StaffModel>(
                          value: child,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  color: Colors.grey.shade200,
                                  child: CachedImageWidget(imageUrl: child.image, iconSize: 26),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    child.fullName,
                                    style: const TextStyle(
                                      color: Color(0xFF6B9080),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    child.contact,
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                )
            ),
          ),
        ),
      ],
    );
  }
}
