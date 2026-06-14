import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/course_overview_controller.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/status_card.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/student_status_list_item.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/course_overview/student_status_model.dart';

class CourseOverviewScreen extends StatelessWidget {
  CourseOverviewScreen({super.key});

  final CourseOverviewController controller = Get.find<CourseOverviewController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 30 : null,),
        ),
        title: Text(
          'Course Overview',
          style: TextStyle(
            fontSize: isTab ? 12.sp : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // 1. Status Cards Grid
            Obx((){
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: isTab ? 3 : 1.65,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StatusCard(status: StudentStatus.onTrack, count: controller.courseOverviewStat.value?.onTrack ?? 0),
                  StatusCard(status: StudentStatus.attention, count: controller.courseOverviewStat.value?.attention ?? 0),
                  StatusCard(status: StudentStatus.behind, count: controller.courseOverviewStat.value?.behind ?? 0),
                  StatusCard(status: StudentStatus.critical, count: controller.courseOverviewStat.value?.critical ?? 0),
                ],
              );
            }),

            const SizedBox(height: 14),

            // 2. Student List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Learner',
                  style: TextStyle(fontSize: isTab ? 10.sp : 18, fontWeight: FontWeight.bold),
                ),
                Obx((){
                  return Text(
                    '${controller.filteredStudentList.length} Learner(s)',
                    style: TextStyle(fontSize: isTab ? 10.sp : null, fontWeight: FontWeight.w500),
                  );
                }),
                // Filter SVG Icon
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: SvgPicture.asset(Assets.icons.sort, height: isTab ? 30 : null, width: isTab ? 30 : null,),
                  onSelected: (String result) {
                    controller.selectedFilter.value = result;
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'all',
                          child: Text('All'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'on track',
                          child: Text('On Track'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'attention',
                          child: Text('Attention'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'behind',
                          child: Text('Behind'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'critical',
                          child: Text('Critical Risk'),
                        ),
                      ],
                ),
              ],
            ),
            const Divider().paddingZero,

            // 3. Scrollable Student List
            Expanded(
              child: Obx((){
                if( controller.isLoading.value ){
                  return Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
                }
                if( controller.filteredStudentList.isEmpty ){
                  return Center(child: Text("No Data Found", style: TextStyle(fontSize: isTab ? 10.sp : null),));
                }
                return ListView.separated(
                  itemCount: controller.filteredStudentList.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {

                    final StudentStatusModel model = controller.filteredStudentList[index];

                    return StudentStatusListItem(
                      name: model.fullName,
                      phoneNumber: model.contact,
                      imageUrl: model.image,
                      onViewPressed: () {
                        Get.toNamed(
                            AppRoutes.studentProgress,
                            arguments: {
                          'courseId': controller.courseId,
                          'studentId': model.id
                        });
                      },
                      studentStatus: model.status,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
