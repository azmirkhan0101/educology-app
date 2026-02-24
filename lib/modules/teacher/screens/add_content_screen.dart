import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/add_content_controller.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/quill_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({super.key});

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {

  final AddContentController controller = Get.find<AddContentController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _zoomLinkController = TextEditingController();
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
          title: Text( controller.appTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _buildLabel("Tittle"), // Kept the typo "Tittle" from the screenshot
              _buildTextField("Enter Class Name", _titleController),
              const SizedBox(height: 20),

              _buildLabel("Expected Live Class starting Date & Time"),
              Row(
                children: [
                  Expanded(
                    child: _buildDateTimePickerField(
                      "DD-MM-YYYY",
                      Icons.calendar_today_outlined,
                      _dateController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildDateTimePickerField(
                      "-- : -- AM",
                      Icons.access_time,
                      _timeController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildLabel("Add Class Details"),
              Row(
                children: [
                  Expanded(child: CustomQuillToolbar(controller: _controller)),
                ],
              ),

              /// Editor
              Container(
                height: 150.h,
                //margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: quill.QuillEditor.basic(
                  controller: _controller,
                  config: const quill.QuillEditorConfig(),
                ),
              ),
              const SizedBox(height: 20),

              _buildLabel("Attached Document (Optional)"),
              _buildUploadSection(),
              const SizedBox(height: 20),

              _buildLabel("Share Zoom Link"),
              _buildTextField("Paste your class link here...", _zoomLinkController, maxLines: 3),
              const SizedBox(height: 25,),
              ButtonWidget(
                onPressed: (){

                },
              label: AppStrings.upload,
              gradient: AppColors.primaryButtonGradient,
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          textAlign: TextAlign.left,
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey4E,
          ),
        ),
      ),
    );
  }

  // Helper widget for standard TextFields
  Widget _buildTextField(String hint, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A6572)),
        ),
      ),
    );
  }

  // Helper widget for Date/Time Pickers
  Widget _buildDateTimePickerField(String hint, IconData icon, TextEditingController controller) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon: Icon(icon, size: 18, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onTap: () {
        // Logic for showDatePicker or showTimePicker goes here
      },
    );
  }

  // Helper widget for the Upload section
  Widget _buildUploadSection() {
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
              onPressed: (){

              },
            ),
          ),
        ],
      ),
    );
  }
}

