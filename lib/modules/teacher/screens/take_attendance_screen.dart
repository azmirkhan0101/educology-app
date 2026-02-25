import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

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
      ),
      body: Column(
        children: [
          const Text("Total Students  :  15", style: TextStyle(fontSize: 18, color: Color(0xFF2D5669))),
          const SizedBox(height: 20),
          _buildStatsHeader(),
          const SizedBox(height: 20),
          _buildTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) => const StudentTile(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statColumn("12", "70%", Colors.green),
          const VerticalDivider(thickness: 1, color: Colors.grey, indent: 5, endIndent: 5),
          _statColumn("Late: 2", "20%", Colors.orange),
          const VerticalDivider(thickness: 1, color: Colors.grey, indent: 5, endIndent: 5),
          _statColumn("Absent: 01", "10%", Colors.red),
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

class StudentTile extends StatefulWidget {
  const StudentTile({super.key});

  @override
  State<StudentTile> createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  String attendanceStatus = 'Present';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
      child: Row(
        children: [
          // Student Info
           Expanded(
            flex: 3,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 28.h,
                    width: 28.w,
                    color: AppColors.greyEB,
                    child: CachedImageWidget(
                        imageUrl: Dummy.profileImageUrl,
                      iconSize: 25.r,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rakibul Hasan", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF5BA381))),
                    Text("+8801827347685", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          // Join Time
          const Expanded(flex: 2, child: Center(child: Text("12:00PM", style: TextStyle(color: Colors.grey)))),
          // Attendance Dropdown
          Expanded(
            flex: 2,
            child: Center(
              child: DropdownButton<String>(
                value: attendanceStatus,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                style: TextStyle(
                  color: attendanceStatus == 'Present' ? Colors.green : (attendanceStatus == 'Late' ? Colors.orange : Colors.red),
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    attendanceStatus = newValue!;
                  });
                },
                items: <String>['Present', 'Absent', 'Late']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                        value,
                      style: TextStyle(
                        color: value == 'Present' ? Colors.green : (value == 'Late' ? Colors.orange : Colors.red),)
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}