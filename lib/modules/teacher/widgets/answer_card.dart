
import 'package:dr_dina_educology/data/models/answer/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/cached_image_widget.dart';
import '../../../routes/app_pages.dart';
import '../../content_details/screens/view_document_screen.dart';

class AnswerCard extends StatelessWidget {

  final AnswerModel answerModel;
  final int index;

  const AnswerCard({
    super.key,
    required this.answerModel, required this.index
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    AnswerSubmissionStatus submissionStatus = AnswerSubmissionStatus.values.firstWhere(
          (status) => status.label2.toLowerCase() == answerModel.submissionStatus.toLowerCase(),
      orElse: () => AnswerSubmissionStatus.notSubmitted,
    );

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: isTab ? 70 : 35.h,
                width: isTab ? 70 : 35.w,
                child: CachedImageWidget(imageUrl: answerModel.student.image),
              ),
            ),
            const SizedBox(width: 6),
            // Name and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
                    answerModel.student.fullName,
                    style: TextStyle(
                      color: Color(0xFF6DA382),
                      fontWeight: FontWeight.bold,
                      fontSize: isTab ? 10.sp : 14,
                    ),
                  ),
                  Text(
                    DateFormat("dd MMM yyyy").format(answerModel.createdAt.toLocal()),
                    style: TextStyle(color: Colors.grey, fontSize: isTab ? 9.sp : 12),
                  ),
                ],
              ),
            ),
            // Status Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                submissionStatus.label,
                style: TextStyle(
                  fontSize: isTab ? 9.sp : 12,
                  color: submissionStatus.statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                label: AppStrings.viewAnswer,
                backgroundColor: AppColors.secondaryDarkBlue,
                buttonHeight: 40,
                fontSize: 14,
                padding: EdgeInsets.zero,
                onPressed: (){
                  final pdfUrl = answerModel.answerPdf;
                  if (pdfUrl.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewDocumentScreen(
                          url: pdfUrl,
                          title: "Answer",
                          index: index,
                          showEditIcon: true,
                          submissionId: answerModel.answerId
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No document available to view."),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Obx((){
                return ButtonWidget(
                  label: answerModel.isMarked.value ? "Mark provided" : AppStrings.provideMark,
                  backgroundColor: AppColors.white,
                  isEnabled: !answerModel.isMarked.value,
                  borderColor: AppColors.secondaryDarkBlue,
                  icon: answerModel.isMarked.value ? Icons.done : null,
                  textColor: AppColors.secondaryDarkBlue,
                  borderWidth: 2,
                  buttonHeight: 40,
                  fontSize: 14,
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    Get.toNamed(
                        AppRoutes.provideMark,
                        arguments: {
                          "submissionId" : answerModel.answerId,
                          "index": index
                        }
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}