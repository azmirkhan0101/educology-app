import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/cached_image_widget.dart';

class TakeAttendanceTile extends StatefulWidget {

  final String imageUrl;
  final String name;
  final String time;
  final String phone;

  const TakeAttendanceTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.phone
  });

  @override
  State<TakeAttendanceTile> createState() => _StudentTileState();
}

class _StudentTileState extends State<TakeAttendanceTile> {
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
                      imageUrl: widget.imageUrl,
                      iconSize: 25.r,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( widget.name, style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF5BA381))),
                    Text(widget.phone, style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          // Join Time
          Expanded(flex: 2, child: Center(child: Text(widget.time, style: TextStyle(color: Colors.grey)))),
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