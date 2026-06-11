import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:dr_dina_educology/data/models/attendance/single_attendance_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/single_attendance_controller.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/single_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SingleAttendanceScreen extends StatelessWidget {
  SingleAttendanceScreen({super.key});

  final SingleAttendanceController controller = Get.find<SingleAttendanceController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 30 : null,)),
        title: Text("View Attendance", style: TextStyle(fontSize: isTab ? 12.sp : 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Obx((){
              return Text(
                  "Total Completed Class : ${controller.totalCompletedClass.value}",
                  style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.w500, color: Color(0xFF34495E)));
            }),
            const SizedBox(height: 25),
            //======================Summary Section============================
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx((){
                    return SummaryItem(
                        label: "On Time: ${controller.attendanceStat.value?.onTimeCount ?? 0}",
                        percent: "${controller.attendanceStat.value?.onTimePercentage.toSmartString() ?? 0}%",
                        color: Colors.green
                    );
                  }),
                  VerticalDivider(thickness: 1, color: Colors.grey),
                  Obx((){
                    return SummaryItem(
                        label: "Late: ${controller.attendanceStat.value?.lateCount ?? 0}",
                        percent: "${controller.attendanceStat.value?.latePercentage.toSmartString() ?? 0}%",
                        color: Colors.orange
                    );
                  }),
                  VerticalDivider(thickness: 1, color: Colors.grey,),
                  Obx((){
                    return SummaryItem(
                        label: "Absent: ${controller.attendanceStat.value?.absentCount ?? 0}",
                        percent: "${controller.attendanceStat.value?.absentPercentage.toSmartString() ?? 0}%",
                        color: Colors.red
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //=======================Table Header============================
            Container(
              color: const Color(0xFFE8F6F3),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                      child: Text("Class Name", style: TextStyle(fontSize: isTab ? 10.sp : 14, fontWeight: FontWeight.bold, color: Color(0xFF34495E)))),
                  Expanded(
                      flex: 5,
                      child: Text("Class Start", style: TextStyle(fontSize: isTab ? 10.sp : 14,fontWeight: FontWeight.bold, color: Color(0xFF34495E)))),
                  Expanded(
                      flex: 3,
                      child: Text("Attendance", style: TextStyle(fontSize: isTab ? 10.sp : 14,fontWeight: FontWeight.bold, color: Color(0xFF34495E)))),
                ],
              ),
            ),
            Divider(height: 0.5,).paddingZero,
            // Scrollable List
            Expanded(
              child: Obx((){
                if( controller.isLoading.value ){
                  return Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
                }
                if( controller.attendanceList.isEmpty ){
                  return Center(child: Text("No Data Found", style: TextStyle(fontSize: isTab ? 10.sp : null),));
                }
                return ListView.builder(
                  itemCount: controller.attendanceList.length,
                  itemBuilder: (context, index) {

                    final SingleAttendanceModel model = controller.attendanceList[index];

                    return SingleAttendanceCard(
                      className: model.className,
                      classTime: model.classStart,
                      status: model.status
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

// Small helper widget for the top summary stats
class SummaryItem extends StatelessWidget {
  final String label;
  final String percent;
  final Color color;

  const SummaryItem({super.key, required this.label, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: isTab ? 10.sp : 12)),
        const SizedBox(height: 4),
        Text(percent, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: isTab ? 10.sp : 12)),
      ],
    );
  }
}