import 'dart:io';

import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/provide_mark_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../content_details/widgets/document_item_widget.dart';

class ProvideMarkScreen extends StatelessWidget {

  ProvideMarkScreen({super.key});

  final ProvideMarkController controller = Get.find<ProvideMarkController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 30 : null,)),
        title: Text(
          'Provide Mark',
          style: TextStyle(fontSize: isTab ? 12.sp : 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Upload Corrected Answer paper",
                          style: TextStyle(fontSize: isTab ? 12.sp : 14, color: Colors.grey)),
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
                             Text(
                                 "Max file size: 100 MB",
                                style: TextStyle(fontSize: isTab ? 9.sp : 12, color: Colors.grey)),
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
                          if( controller.pdfFileName.value.isEmpty ){
                            return SizedBox.shrink();
                          }
                          return DocumentItemWidget(pdfUrl: controller.pdfFileName.value);
                        }
                        ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        label: AppStrings.provideMark,
                        controller: controller.marksController,
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.provideHere,
                        validator: (value){
                          if( value == null || value.isEmpty ){
                            return "Mark is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Total Marks",
                        controller: controller.totalMarksController,
                        keyboardType: TextInputType.number,
                        hintText: "total marks",
                        validator: (value){
                          if( value == null || value.isEmpty ){
                            return "Total mark is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: AppStrings.provideAShortFeedback,
                        controller: controller.feedbackController,
                        hintText: AppStrings.provideHere,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Obx((){
                  return ButtonWidget(
                    label: AppStrings.update,
                    isLoading: controller.isUploading.value,
                    gradient: AppColors.primaryButtonGradient,
                    buttonHeight: 50,
                    buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                    fontSize: 16,
                    onPressed: (){
                      if( formKey.currentState!.validate() ){
                        controller.uploadMark();
                      }
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
            ],
          ),
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
      controller.pdfFileName.value = fileName;
      controller.pdfFile = File(result.files.single.path!);
    }
  }
}