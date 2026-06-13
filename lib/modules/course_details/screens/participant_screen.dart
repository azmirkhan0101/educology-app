import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/data/models/course_overview/student_status_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/participants_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/text_widget.dart';
import '../widgets/participant_list_item.dart';

class ParticipantScreen extends StatelessWidget {
  ParticipantScreen({super.key});

  final ParticipantsController controller = Get.find<ParticipantsController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: TextWidget(
          text: "Participants",
          fontSize: isTab ? 12.sp : 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp, size: isTab ? 30 : null),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            //========================Search Bar=========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                onChanged: (query){
                  controller.filterParticipants(query);
                },
                style: TextStyle(fontSize: isTab ? 10.sp : null),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone no.',
                  hintStyle: TextStyle( fontSize: isTab ? 10.sp : null, color: Colors.grey.shade400),
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                "Teacher",
                style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            //============================TEACHER========================
            Obx(() {
              return ParticipantListItem(
                name: controller.teacherModel.value?.fullName ?? "",
                phoneNumber: controller.teacherModel.value?.contact ?? "",
                imageUrl: controller.teacherModel.value?.image ?? "",
                studentStatus: null,
                showDivider: false,
              );
            }),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                AppStrings.assistants,
                style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            //============================ASSISTANT========================
            Obx(() {
              return ParticipantListItem(
                name: controller.assistantModel.value?.fullName ?? "",
                phoneNumber: controller.assistantModel.value?.contact ?? "",
                imageUrl: controller.assistantModel.value?.image ?? "",
                studentStatus: null,
                showDivider: false,
              );
            }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    'Student( ${controller.participantsList.value.length} Students )',
                    style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
            const Divider().paddingZero,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredParticipantsList.isEmpty) {
                    return Center(child: Text("No Data Found"));
                  }
                  return ListView.separated(
                    itemCount: controller.filteredParticipantsList.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final StudentStatusModel model =
                          controller.filteredParticipantsList[index];

                      return ParticipantListItem(
                        name: model.fullName,
                        phoneNumber: model.contact,
                        imageUrl: model.image,
                        studentStatus: model.status,
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
