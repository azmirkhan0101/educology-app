import 'package:dr_dina_educology/modules/teacher/controllers/student_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/student_report/student_report_model.dart';

class StudentsReportScreen extends StatelessWidget {
  StudentsReportScreen({super.key});

  final StudentReportController controller = Get.find<StudentReportController>();

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
        title: const Text(
          'Students Report',
          style: TextStyle(color: Color(0xFF4A6572), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4A6572)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Table Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderCell(label: 'Student Name', flex: 2),
                HeaderCell(label: 'Attendance', flex: 2),
                HeaderCell(label: 'H.w. Completed', flex: 2),
                HeaderCell(label: 'H.w. Pending', flex: 2),
                HeaderCell(label: 'Exam Grade', flex: 2),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // Scrollable List
          Expanded(
            child: Obx((){

              if( controller.isStudentReportLoading.value ){
                return const Center(child: CircularProgressIndicator());
              }

              if( controller.studentReportList.isEmpty ){
                return const Center(child: Text("No Data Found"));
              }

              return ListView.separated(
                itemCount: controller.studentReportList.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
                itemBuilder: (context, index) {

                  final StudentReportModel model = controller.studentReportList[index];

                  return StudentRow(
                    studentName: model.studentName,
                    attendance: model.attendance,
                    hwCompleted: model.hwCompleted,
                    hwPending: model.hwPending,
                    examGrade: model.examGrade
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const HeaderCell({super.key, required this.label, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A6572),
        ),
      ),
    );
  }
}

class StudentRow extends StatelessWidget {

  final String studentName;
  final String attendance;
  final String hwCompleted;
  final String hwPending;
  final String examGrade;

  const StudentRow({
    super.key,
    required this.studentName,
    required this.attendance,
    required this.hwCompleted,
    required this.hwPending,
    required this.examGrade
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        children: [
          DataCell(text: studentName, flex: 2, isName: true),
          DataCell(text: attendance, flex: 2),
          DataCell(text: hwCompleted, flex: 2),
          DataCell(text: hwPending, flex: 2),
          DataCell(text: examGrade, flex: 2)
        ],
      ),
    );
  }
}

class DataCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool isName;
  const DataCell({required this.text, required this.flex, this.isName = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: isName ? Colors.black87 : Colors.grey[600],
          fontWeight: isName ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}