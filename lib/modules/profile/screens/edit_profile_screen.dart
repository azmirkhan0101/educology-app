import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_date_picker.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/profile/widgets/photo_edit_widget.dart';
import 'package:dr_dina_educology/modules/profile/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import '../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(
          text: AppStrings.editProfile,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: editProfileFormKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                //======================IMAGE EDIT WIDGET=======================
                Obx(() {
                  return PhotoEditWidget(
                    imageUrl: controller.profileImageUrl.value,
                    onImagePicked: (image) {
                      controller.profileImage.value = image;
                    },
                  );
                }),
                SizedBox(height: 10),
                //=========================NAME=================================
                Row(
                  spacing: 4,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: AppStrings.name,
                        hintText: AppStrings.firstName,
                        controller: controller.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "first name required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        label: "",
                        hintText: AppStrings.lastName,
                        controller: controller.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "last name required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //=======================DATE OF BIRTH=====================
                CustomDatePicker(
                  initialDate: controller.dateOfBirth ?? DateTime.now(),
                  label: AppStrings.dateOfBirth,
                  onDateSelected: (date) {
                    print(date?.toIso8601String());
                    controller.dateOfBirth = date;
                  },
                  firstDay: DateTime(1900),
                  lastDay: DateTime.now(),
                  initialYear: DateTime.now().year,
                  firstYear: 1900,
                  lastYear: DateTime.now().year,
                ),
                SizedBox(height: 10),
                //========================GENDER============================
                genderDropdown(),
                SizedBox(height: 10),
                //=======================ABOUT ME============================
                CustomTextField(
                  label: AppStrings.aboutMe,
                  hintText: AppStrings.writeAboutYou,
                  controller: controller.aboutMeController,
                  maxLines: 4,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    text: AppStrings.max200Word,
                    fontSize: 14,
                    fontColor: AppColors.grey92,
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return ButtonWidget(
                    label: AppStrings.update,
                    isLoading: controller.isEditProfileLoading.value,
                    gradient: AppColors.primaryButtonGradient,
                    onPressed: () {
                      if (editProfileFormKey.currentState!.validate()) {
                        controller.updateProfile();
                      }
                    },
                  );
                }),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget genderDropdown() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.gender,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            child: DropdownButtonFormField<String>(
              value: controller.gender.value,
              decoration: InputDecoration(
                // The rounded border and light grey color
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: const Color(0xFFF9F9F9),
              ),
              // Styling the text and icon
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              dropdownColor: Colors.white,
              items: <String>['male', 'female', 'others'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text("${value[0].toUpperCase()}${value.substring(1).toLowerCase()}",),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  controller.gender.value = newValue;
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
