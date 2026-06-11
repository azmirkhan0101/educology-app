import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/data/models/marks/marks_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/view_marks_controller.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/view_marks_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/text_widget.dart';
import '../../content_details/screens/view_document_screen.dart';

class ViewAllMarksScreen extends StatelessWidget {
  ViewAllMarksScreen({super.key});

  final ViewMarksController controller = Get.find<ViewMarksController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text("View All Marks", style: TextStyle(fontSize: isTab ? 12.sp : 16, fontWeight: FontWeight.w700),),
      leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_rounded, size: isTab ? 30 : null,))
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
                child: Obx((){
                  if( controller.isLoading.value ){
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
                  }
                  if( controller.marksList.isEmpty ){
                    return Center(child: Text("No Marks Found", style: TextStyle(fontSize: isTab ? 10.sp : null),));
                  }
                  return ListView.builder(
                    itemCount: controller.marksList.length,
                      itemBuilder: (context, index){

                      final MarksModel model = controller.marksList[index];

                      return ViewMarksItemWidget(
                          status: model.status,
                          title: model.title,
                          //STRING
                          deadline: model.deadline,
                          marksObtained: model.marks,
                          feedback: model.feedback ?? "",
                          instructorName: model.teacher.fullName,
                          //DATETIME
                          postedAt: model.postedAt,
                          imageUrl: model.teacher.image,
                          isMarked: model.isMarked,
                          onViewAnswer: (){
                            showAnswerTypeSelectionDialog(
                                context: context,
                                submittedAnswerUrl: model.answerPdf,
                                correctAnswerUrl: model.correctAnswerPdf
                            );
                          }
                      );
                      });
                })
            )
          ],
        ),
      ),
    );
  }

  //SHOW DIALOG - SUBMITTED ANSWER | CORRECT ANSWER
  Future<void> showAnswerTypeSelectionDialog({
    required BuildContext context,
    required String? submittedAnswerUrl,
    required String? correctAnswerUrl
}) async{
    Get.dialog(
        AlertDialog(
          backgroundColor: AppColors.greyB2,
          content: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget(
                text: AppStrings.viewAnswer,
                fontColor: AppColors.secondaryDarkBlue,
                fontWeight: FontWeight.bold,
              ),
              const TextWidget(
                text: "Select which answer you want to view.",
                fontColor: AppColors.grey4E,
                fontSize: 14
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actions: [
            Column(
              spacing: 10,
              children: [
                ButtonWidget(
                  buttonHeight: 40,
                  label: "Submitted Answer",
                  fontSize: 14,
                  backgroundColor: AppColors.secondaryDarkBlue,
                  onPressed: (){
                    Get.back();
                    final pdfUrl = submittedAnswerUrl;
                    if (pdfUrl != null && pdfUrl.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDocumentScreen(
                            url: pdfUrl,
                            title: "Submitted Answer",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No answer found."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
                ButtonWidget(
                  buttonHeight: 40,
                  label: "Correct Answer",
                  fontSize: 14,
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: (){
                    Get.back();
                    final pdfUrl = correctAnswerUrl;
                    if (pdfUrl != null && pdfUrl.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDocumentScreen(
                            url: pdfUrl,
                            title: "Correct Answer",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No answer found."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        )
    );
  }
}
