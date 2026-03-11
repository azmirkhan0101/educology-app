import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/data/models/marks/marks_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/view_marks_controller.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/view_marks_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllMarksScreen extends StatelessWidget {
  ViewAllMarksScreen({super.key});

  final ViewMarksController controller = Get.find<ViewMarksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text("View All Marks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
                child: Obx((){
                  if( controller.isLoading.value ){
                    return Center(child: CircularProgressIndicator());
                  }
                  if( controller.marksList.isEmpty ){
                    return Center(child: Text("No Marks Found"));
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
}
