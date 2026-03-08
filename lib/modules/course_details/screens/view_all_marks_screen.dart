import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/view_exam_item_widget.dart';
import 'package:flutter/material.dart';

class ViewAllMarksScreen extends StatelessWidget {
  const ViewAllMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(AppStrings.viewAllExams, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
