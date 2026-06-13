import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/check_answer_controller.dart';

class CheckAnswerScreen extends StatelessWidget {

  CheckAnswerScreen({super.key});

  final CheckAnswerController controller = Get.find<CheckAnswerController>();

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
          'Check Answer',
          style: TextStyle(fontSize: isTab ? 12.sp : 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx((){
        // Using direct access to Rx variables for better reactivity tracking
        final isLoading = controller.answerHelper.isLoading.value;
        final items = controller.answerHelper.items;

        if( isLoading && items.isEmpty ){
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGold,),
          );
        }
        
        if( items.isEmpty ) {
          return Center(
            child: Text("No answers found", style: TextStyle(fontSize: isTab ? 12.sp : null),),
          );
        }
        
        return ListView.separated(
          controller: controller.answerScrollController,
          padding: const EdgeInsets.all(16.0),
          itemCount: items.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            return AnswerCard(
                answerModel: items[index],
              index: index
            );
          },
        );
      }),
    );
  }
}
