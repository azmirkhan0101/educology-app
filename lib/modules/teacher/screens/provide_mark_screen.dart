import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class ProvideMarkScreen extends StatelessWidget {
  const ProvideMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text(
          'Provide Mark',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload Corrected Answer papaer",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),

            // Upload Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(Assets.icons.upload),
                  const Text("Max file size: 25 MB",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 15),
                  IntrinsicWidth(
                    child: ButtonWidget(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      label: AppStrings.uploadFile,
                      fontSize: 14,
                      buttonHeight: 40,
                      backgroundColor: AppColors.secondaryDarkBlue,
                      onPressed: (){

                      },
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text("Provide mark", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            _buildTextField("Provide here"),

            const SizedBox(height: 25),
            const Text("Provide a short feedback", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            _buildTextField("Provide here", maxLines: 3),

            const Spacer(),

            // Update Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ButtonWidget(
                  label: AppStrings.update,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 50,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}