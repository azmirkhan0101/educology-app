import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/extensions.dart';

class GenerateZoomSwitch extends StatelessWidget {

  final RxBool isZoomEnabled = false.obs;
  final Function(bool enabled) onChanged;

  GenerateZoomSwitch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
         Text(
          "Generate zoom link",
          style: TextStyle(fontSize: isTab ? 12.sp : 16, fontWeight: FontWeight.w500),
        ),

        // Wrap the custom switch in Obx
        Obx(() => GestureDetector(
          onTap: (){
            isZoomEnabled.toggle();
            onChanged(isZoomEnabled.value);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50,
            height: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Apply gradient only if enabled, else use a grey background
              gradient: isZoomEnabled.value
                  ? AppColors.primaryButtonGradient
                  : null,
              color: isZoomEnabled.value
                  ? null
                  : Colors.grey.shade300,
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: isZoomEnabled.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
                  ],
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}