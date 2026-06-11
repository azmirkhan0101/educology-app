import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import 'button_widget.dart';

void showCommentDialog({
  required String title,
  required String subTitle,
  required TextEditingController controller,
  required Function(String) onSubmit,
  required bool isTab
}) {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isTab ? 10.sp : 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              // Text Input Field
              TextFormField(
                controller: controller,
                maxLines: 4,
                style: TextStyle(fontSize: isTab ? 10.sp : null),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: subTitle,
                  hintStyle: TextStyle(fontSize: isTab ? 10.sp : null, color: AppColors.grey4E),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFF0F0F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Submit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    label: AppStrings.cancel,
                    backgroundColor: Colors.black54,
                    buttonHeight: 45,
                    fontSize: isTab ? 14 : 18,
                    onPressed: (){
                      Get.back();
                    },
                  ),
                  ButtonWidget(
                    label: AppStrings.submit,
                    gradient: AppColors.primaryButtonGradient,
                    buttonHeight: 45,
                    fontSize: isTab ? 14 : 18,
                    onPressed: (){
                      if( formKey.currentState!.validate() ){
                        Get.back();
                        onSubmit(controller.text.trim());
                      }
                    }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}