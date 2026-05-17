import 'dart:io';

import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_date_picker.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/document_item_widget.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/documents_list.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/add_content_controller.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/custom_time_picker.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/generate_link_switch.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/quill_toolbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/app_constants.dart';

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({super.key});

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {

  final AddContentController controller = Get.find<AddContentController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final quill.QuillController quillController = quill.QuillController.basic();
  //SINGLE PDF FILE NAME FOR ANNOUNCEMENT
  RxString pdfFileName = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          controller.appTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //========================CLASS TITLE=====================
                if( controller.contentType != AddContentType.announcement )
                  CustomTextField(
                    label: AppStrings.title,
                    validator: (value){
                      if( value == null || value.isEmpty ){
                        return "Class name is required";
                      }
                      return null;
                    },
                    controller: controller.titleController,
                    hintText: AppStrings.enterClassName
                  ),
                const SizedBox(height: 15),
                //======================START DATE AND TIME========================
                if( controller.contentType != AddContentType.announcement )
                  buildLabel(controller.contentType == AddContentType.cClass ?
                  AppStrings.expectedLiveClass
                      : AppStrings.startDateAndTime),
                if( controller.contentType != AddContentType.announcement )
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: CustomDatePicker(
                              label: null,
                              validator: (value){
                                if( value == null ){
                                  return "start date is required";
                                }
                                return null;
                              },
                              onDateSelected: (date){
                                if( date != null ){
                                  controller.startDate = date;
                                }
                              },
                              firstDay: DateTime.now().toLocal(),
                              lastDay: DateTime(DateTime.now().year + 1, 12),
                              initialYear: DateTime.now().year,
                              firstYear: DateTime.now().year,
                              lastYear: DateTime.now().year + 1
                          )
                      ),
                      Expanded(
                          child: CustomTimePicker(
                              label: null,
                              validator: (time){
                                if( time == null || time.isEmpty ){
                                  return "Time is required";
                                }
                                return null;
                              },
                              onTimeSelected: (timeText){
                                if( timeText != null ){
                                  controller.startTimeController.text = timeText;
                                }
                              }
                          )
                      )
                    ],
                  ),
                //======================DEAD LINE DATE AND TIME====================
                if( controller.contentType == AddContentType.homeWork || controller.contentType == AddContentType.exam  )
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: CustomDatePicker(
                                label: "Deadline",
                                validator: (value){
                                  if( value == null ){
                                    return "Date is required";
                                  }
                                  return null;
                                },
                                onDateSelected: (date){
                                  if( date != null ){
                                    controller.deadlineDate = date;
                                  }
                                },
                                firstDay: DateTime.now().toLocal(),
                                lastDay: DateTime(DateTime.now().year + 1, 12),
                                initialYear: DateTime.now().year,
                                firstYear: DateTime.now().year,
                                lastYear: DateTime.now().year + 1
                            )
                        ),
                        Expanded(
                            child: CustomTimePicker(
                                label: "",
                                validator: (time){
                                  if( time == null || time.isEmpty ){
                                    return "Time is required";
                                  }
                                  return null;
                                },
                                onTimeSelected: (timeText){
                                  if( timeText != null ){
                                    controller.deadlineTimeController.text = timeText;
                                  }
                                }
                            )
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 15),

                buildLabel(
                    controller.contentType == AddContentType.cClass ? AppStrings.addClassDetails
                        : controller.contentType == AddContentType.exam ? AppStrings.addExamDetails
                        : controller.contentType == AddContentType.homeWork ? AppStrings.addHomeworkDetails
                        : AppStrings.addAnnouncement
                ),
                //========================QUILL TOOLBAR=======================
                Row(
                  children: [
                    Expanded(
                        child: CustomQuillToolbar(
                            controller: quillController,
                        )
                    ),
                  ],
                ),
                //=======================QUILL EDITOR=========================
                Container(
                  height: 150.h,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: quill.QuillEditor.basic(
                    controller: quillController,
                    config: const quill.QuillEditorConfig(),
                  ),
                ),
                const SizedBox(height: 15),
                //=======================UPLOAD PDF SECTION=====================
                buildLabel(
                    controller.contentType == AddContentType.cClass || controller.contentType == AddContentType.announcement ? "Attached Document (Optional)"
                        : "Attached Question"
                ),
                uploadPdfSection(),
                SizedBox(height: 10,),
                //=====================LIST OF PICKED PDF FILES if not announcement======================
                if( controller.contentType != AddContentType.announcement )
                Obx((){
                  if( controller.pdfFileNames.isEmpty ){
                    return SizedBox.shrink();
                  }
                  return DocumentsList(
                      documents: controller.pdfFileNames.value
                  );
                }),
                //==================SINGLE PDF FILE IF ANNOUNCEMENT
                if( controller.contentType == AddContentType.announcement )
                Obx((){
                  if( pdfFileName.value.isEmpty ){
                    return SizedBox.shrink();
                  }
                  return DocumentItemWidget(pdfUrl: pdfFileName.value);
                }
                ),
                const SizedBox(height: 15),
                //=================CLASS LINK========================
                if( controller.contentType == AddContentType.cClass )...[
                  CustomTextField(
                    label: AppStrings.shareZoomLink,
                    controller: controller.zoomLinkController,
                    hintText: AppStrings.pasteYourClassLinkHere,
                    validator: (value){
                      if( !controller.isZoomEnabled && controller.zoomLinkController.text.isEmpty ){
                        return "Zoom link is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade200,)),
                      TextWidget(text: "Or"),
                      Expanded(child: Divider(color: Colors.grey.shade200,)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  //=================SWITCH TO TOGGLE AUTO GEN ZOOM LINK=================
                  GenerateZoomSwitch(
                    onChanged: (enabled){
                      controller.isZoomEnabled = enabled;
                      print("Zoom enabled: ${controller.isZoomEnabled}");
                      _formKey.currentState?.validate();
                    },
                  )
                ],
                const SizedBox(height: 25),
                //=======================UPLOAD BUTTON=====================
                Obx((){
                  return ButtonWidget(
                    isLoading: controller.isLoading.value,
                      onPressed: (){
                        if( _formKey.currentState!.validate() ){
                          controller.quillRawText = quillController.document.toPlainText().trim();
                          final deltaJson = quillController.document.toDelta().toJson();
                          final converter = QuillDeltaToHtmlConverter(deltaJson);
                          controller.detailsHtmlString = converter.convert();
                          if( controller.contentType == AddContentType.cClass ){
                            controller.uploadClass();
                          }else if( controller.contentType == AddContentType.exam ){
                            controller.uploadExam();
                          }else if( controller.contentType == AddContentType.homeWork ){
                            controller.uploadHomeWork();
                          }else{
                            controller.uploadAnnouncement();
                          }
                        }
                      },
                      label: AppStrings.upload,
                      gradient: AppColors.primaryButtonGradient,
                      buttonHeight: 50
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

  // Helper widget to build labels
  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          textAlign: TextAlign.left,
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey4E,
          ),
        ),
      ),
    );
  }

  // Helper widget for the Upload section
  Widget uploadPdfSection() {
    return Container(
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
          const SizedBox(height: 5),
          IntrinsicWidth(
            child: ButtonWidget(
              label: AppStrings.uploadFile,
              fontSize: 14,
              buttonHeight: 40,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              backgroundColor: AppColors.secondaryDarkBlue,
              onPressed: () {
                pickPdfFile();
              },
            ),
          ),
        ],
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
      //SINGLE FILE IF ANNOUNCEMENT
      if( controller.contentType == AddContentType.announcement ){
        pdfFileName.value = fileName;
        controller.pdfFile = File(result.files.single.path!);
      }else{//MULTIPLE PDF FILES IF NOT ANNOUNCEMENT
        controller.pdfFileNames.add(fileName);
        controller.pdfFiles.add(File(result.files.single.path!));
      }
    }
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    await Future.delayed(Duration.zero);

    print("Showing picker");
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      // We use 'mounted' check to ensure context is still valid after await
      if (!context.mounted) return TimeOfDay.now();

      print("Picked: $picked");

      String formattedTime = picked.format(context);
      return picked;
      print("Selected: $formattedTime");
    } else {
      print("Time is null");
      return TimeOfDay.now();
    }
  }
}
