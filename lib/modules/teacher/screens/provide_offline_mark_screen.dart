import 'dart:io';

import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/provide__offline_mark_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../content_details/widgets/document_item_widget.dart';

class ProvideOfflineMarkScreen extends StatelessWidget {
  ProvideOfflineMarkScreen({super.key});

  final ProvideOfflineMarkController controller = Get.find<ProvideOfflineMarkController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 30 : null),
        ),
        title: Text(
          'Provide Offline Mark',
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
                      Text(
                        "Search and select a student",
                        style: TextStyle(fontSize: isTab ? 12.sp : 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),

                      // Search Input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: TextField(
                          controller: controller.searchController,
                          style: TextStyle(fontSize: isTab ? 10.sp : null),
                          onChanged: (query) {
                            //controller.searchStudents(query: query);
                            controller.searchQuery.value = query;
                          },
                          decoration: InputDecoration(
                            hintText: 'Search student by name or phone no.',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: isTab ? 10.sp : null,
                            ),
                            prefixIcon: const Icon(Icons.search, color: Color(0xFF4A6572)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Dynamic Area: Selected Student Card / Search Loader / Search Results List
                      Obx(() {
                        final selectedStudent = controller.selectedStudent.value;

                        // Case 1: Student is selected -> Show Selected Card
                        if (selectedStudent != null) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3FAF6),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF6BA587).withOpacity(0.4)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: isTab ? 50 : 40.h,
                                    width: isTab ? 50 : 40.w,
                                    color: AppColors.greyEB,
                                    child: CachedImageWidget(
                                      imageUrl: selectedStudent.image,
                                      iconSize: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedStudent.fullName,
                                        style: TextStyle(
                                          fontSize: isTab ? 11.sp : 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF2C3E50),
                                        ),
                                      ),
                                      if (selectedStudent.contact.isNotEmpty)
                                        Text(
                                          selectedStudent.contact,
                                          style: TextStyle(
                                            fontSize: isTab ? 9.sp : 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.redAccent),
                                  onPressed: () {
                                    controller.clearSelectedStudent();
                                  },
                                )
                              ],
                            ),
                          );
                        }

                        // Case 2: Searching Indicator
                        if (controller.isSearching.value) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryGold,
                                strokeWidth: 2.5,
                              ),
                            ),
                          );
                        }

                        // Case 3: Display searched student list
                        if (controller.searchedStudents.isNotEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            constraints: const BoxConstraints(maxHeight: 220),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.searchedStudents.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final student = controller.searchedStudents[index];

                                return InkWell(
                                  onTap: () {
                                    controller.selectStudent(student);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Container(
                                            height: isTab ? 45 : 38.h,
                                            width: isTab ? 45 : 38.w,
                                            color: AppColors.greyEB,
                                            child: CachedImageWidget(
                                              imageUrl: student.image,
                                              iconSize: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                student.fullName,
                                                style: TextStyle(
                                                  fontSize: isTab ? 10.sp : 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              if (student.contact.isNotEmpty)
                                                Text(
                                                  student.contact,
                                                  style: TextStyle(
                                                    fontSize: isTab ? 8.sp : 11,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.check_circle_outline,
                                          color: AppColors.secondaryDarkBlue,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }),

                      const SizedBox(height: 15),
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
                              style: TextStyle(fontSize: isTab ? 9.sp : 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            IntrinsicWidth(
                              child: ButtonWidget(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                label: AppStrings.uploadFile,
                                fontSize: 14,
                                buttonHeight: 40,
                                backgroundColor: AppColors.secondaryDarkBlue,
                                onPressed: () {
                                  pickPdfFile();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        if (controller.pdfFileName.value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return DocumentItemWidget(pdfUrl: controller.pdfFileName.value);
                      }),
                      const SizedBox(height: 12),
                      CustomTextField(
                        label: AppStrings.provideMark,
                        controller: controller.marksController,
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.provideHere,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                child: Obx(() {
                  return ButtonWidget(
                    label: AppStrings.update,
                    isLoading: controller.isUploading.value,
                    gradient: AppColors.primaryButtonGradient,
                    buttonHeight: 50,
                    buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                    fontSize: 16,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
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
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      String fileName = result.files.single.name;
      controller.pdfFileName.value = fileName;
      controller.pdfFile = File(result.files.single.path!);
    }
  }
}