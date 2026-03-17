import 'dart:io';

import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/modules/student/controllers/submit_answer_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../content_details/widgets/document_item_widget.dart';

class SubmitAnswerScreen extends StatelessWidget {

  SubmitAnswerScreen({super.key});

  final SubmitAnswerController controller = Get.find<SubmitAnswerController>();
  RxString pdfFileName = "".obs;

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
          'Submit Answer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload your answer(pdf)",
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
                  const Text("Max file size: 5 MB",
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
                        pickPdfFile();
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
              Obx((){
                if( pdfFileName.value.isEmpty ){
                  return SizedBox.shrink();
                }
                return DocumentItemWidget(pdfUrl: pdfFileName.value);
              }
              ),
            const SizedBox(height: 12),
            const Spacer(),

            // Update Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Obx((){
                return ButtonWidget(
                  label: AppStrings.submit,
                  isLoading: controller.isUploading.value,
                  gradient: AppColors.primaryButtonGradient,
                  buttonHeight: 50,
                  fontSize: 16,
                  onPressed: (){
                    controller.submitAnswer();
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

    if (result != null && result.files.single.path != null) {
      String fileName = result.files.single.name;
      pdfFileName.value = fileName;
      controller.pdfFile = File(result.files.single.path!);
    }
  }
}