import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/take_attendance_controller.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/take_attendance_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/take_attendance/take_attendance_model.dart';

class TakeAttendanceScreen extends StatelessWidget {

  TakeAttendanceScreen({super.key});

  final TakeAttendanceController controller = Get.find<TakeAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text("Take Attendance", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                controller.uploadAttendance();
              },
              icon: Obx((){
                if( controller.isUploading.value ){
                  return SizedBox(
                    height: 18,
                      width: 18,
                      child: CircularProgressIndicator( color: AppColors.primaryGold, strokeWidth: 2,));
                }
                return Icon( Icons.upload, color: Colors.black);
              })
          )
        ],
      ),
      body: Column(
        children: [
          Obx((){
            return Text("Total Students : ${controller.totalStudents.value}", style: TextStyle(fontSize: 18, color: Color(0xFF2D5669)));
          }),
          const SizedBox(height: 20),
          Obx((){
            return _buildStatsHeader(
                onTime: controller.attendanceStat.value?.onTimeCount ?? 0,
                late: controller.attendanceStat.value?.lateCount ?? 0,
                absent: controller.attendanceStat.value?.absentCount ?? 0,
                onTimePercentage: controller.attendanceStat.value?.onTimePercentage ?? 0,
                latePercentage: controller.attendanceStat.value?.latePercentage ?? 0,
                absentPercentage: controller.attendanceStat.value?.absentPercentage ?? 0
            );
          }),
          const SizedBox(height: 20),
          _buildTableHeader(),
          Expanded(
            child: Obx((){
              if( controller.isFormLoading.value ){
                return Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
              }
              if( controller.attendanceForm.isEmpty ){
                return Center(child: Text("No Data Found"));
              }
              return ListView.builder(
                itemCount: controller.attendanceForm.value.length,
                itemBuilder: (context, index) {

                  final TakeAttendanceModel model = controller.attendanceForm[index];
                  //TODO: PASS STATUS IN THIS WIDGET
                  return TakeAttendanceTile(
                      imageUrl: model.student.image,
                      name: model.student.fullName,
                      time: model.time,
                      phone: model.student.contact
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader({required int onTime, required int late, required int absent, required double onTimePercentage, required double latePercentage, required double absentPercentage}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statColumn("Total: $onTime", "$onTimePercentage%", Colors.green),
          const VerticalDivider(thickness: 1, color: Colors.grey, indent: 5, endIndent: 5),
          _statColumn("Late: $late", "$latePercentage%", Colors.orange),
          const VerticalDivider(thickness: 1, color: Colors.grey, indent: 5, endIndent: 5),
          _statColumn("Absent: $absent", "$absentPercentage%", Colors.red),
        ],
      ),
    );
  }

  Widget _statColumn(String top, String bottom, Color color) {
    return Column(
      children: [
        Text(top, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(bottom, style: TextStyle(color: color, fontSize: 14)),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: const Color(0xFFF0FAF7),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text("Student", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D5669), fontSize: 14))),
          Expanded(flex: 2, child: Center(child: Text("Join Time", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D5669), fontSize: 14)))),
          Expanded(flex: 2, child: Center(child: Text("Attendance", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D5669), fontSize: 14)))),
        ],
      ),
    );
  }
}