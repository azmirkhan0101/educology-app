import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/single_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleAttendanceScreen extends StatelessWidget {
  const SingleAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text("View Attendance", style: TextStyle(color: Color(0xFF34495E), fontWeight: FontWeight.w600)),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const Text("Total Completed Class : 15",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF34495E))),
            const SizedBox(height: 10),
            // Summary Section
            const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SummaryItem(label: "On Time: 07", percent: "70%", color: Colors.green),
                  VerticalDivider(thickness: 1, color: Colors.grey),
                  SummaryItem(label: "Late: 07", percent: "20%", color: Colors.orange),
                  VerticalDivider(thickness: 1, color: Colors.grey,),
                  SummaryItem(label: "Absent: 01", percent: "10%", color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Table Header
            Container(
              color: const Color(0xFFE8F6F3),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              child: const Row(
                children: [
                  Expanded(child: Text("Class Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF34495E)))),
                  Expanded(child: Text("Class Start", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Color(0xFF34495E)))),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Attendance", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Color(0xFF34495E))),
                      Expanded(child: Icon(Icons.arrow_drop_down, size: 15, color: Color(0xFF34495E))),
                    ],
                  )),
                ],
              ),
            ),
            Divider(height: 0.5,).paddingZero,
            // Scrollable List
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  // Mocking the data logic based on your image
                  String status = "On Time";
                  if (index == 2) status = "Late 10min";
                  if (index == 5) status = "Absent";
                  if (index == 9) status = "Late 30min";

                  return SingleAttendanceCard(
                    className: "Lecture-1 (Algebra..",
                    classTime: "19 Nov | 12:00PM",
                    attendanceStatus: AttendanceStatus.onTime,
                  );
                },
              ),
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
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Text(percent, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}