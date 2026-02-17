import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
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

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(text: AppStrings.editProfile,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_sharp)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10,),
              PhotoEditWidget(
                imageUrl: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                onImagePicked: (image){

                },
              ),
              SizedBox(height: 10,),
              _buildTextField(label: AppStrings.name, hint: AppStrings.enterYourName),
              SizedBox(height: 10,),
              _buildTextField(label: AppStrings.email, hint: AppStrings.enterYourEmail),
              SizedBox(height: 10,),
              _buildTextField(label: AppStrings.dateOfBirth, hint: AppStrings.ddmmyyyy),
              SizedBox(height: 10,),
              _buildTextField(label: AppStrings.gender, hint: AppStrings.male),
              SizedBox(height: 10,),
              _buildTextField(label: AppStrings.aboutMe, hint: AppStrings.writeAboutYou, maxLines: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextWidget(
                    text: AppStrings.max200Word,
                  fontSize: 14,
                  fontColor: AppColors.grey92,
                ),
              ),
              SizedBox(height: 10,),
              ButtonWidget(label: AppStrings.update,
              gradient: AppColors.primaryButtonGradient,
                onPressed: (){
                //TODO: Update Profile
                },
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for text fields to keep code clean
  Widget _buildTextField({
    int maxLines = 1,
    required String label,
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}
