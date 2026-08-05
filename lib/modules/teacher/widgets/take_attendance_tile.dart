import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/cached_image_widget.dart';

class TakeAttendanceTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String time;
  final String phone;
  final String status;
  final Function(String?) onSelection;

  const TakeAttendanceTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.phone,
    required this.status,
    required this.onSelection,
  });

  @override
  State<TakeAttendanceTile> createState() => _StudentTileState();
}

class _StudentTileState extends State<TakeAttendanceTile> {
  late TakeAttendanceStatus takeAttendanceStatus;

  @override
  void initState() {
    super.initState();
    takeAttendanceStatus = TakeAttendanceStatus.values.firstWhere(
      (element) => element.label2 == widget.status,
    );
  }

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
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
                    height: isTab ? 65 : 28.h,
                    width: isTab ? 65 : 28.w,
                    color: AppColors.greyEB,
                    child: CachedImageWidget(
                      imageUrl: widget.imageUrl,
                      iconSize: 25.r,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: isTab ? 10.sp : null,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5BA381),
                        ),
                      ),
                      Text(
                        widget.phone,
                        style: TextStyle(fontSize: isTab ? 9.sp : 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Join Time
          Expanded(
            flex: 2,
            child: Center(
              child: Text(widget.time, style: TextStyle(fontSize: isTab ? 9.sp : null, color: Colors.grey)),
            ),
          ),
          // Attendance Dropdown
          Expanded(
            flex: 2,
            child: Center(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: takeAttendanceStatus.label,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                style: TextStyle(
                  color: takeAttendanceStatus == TakeAttendanceStatus.notMarked
                      ? Colors.green
                      : (takeAttendanceStatus == TakeAttendanceStatus.late
                            ? Colors.orange
                            : Colors.red),
                  fontWeight: FontWeight.w500,
                  fontSize: isTab ? 9.sp : 12
                ),
                onChanged: (String? newValue) {
                  widget.onSelection(newValue);
                  if (newValue != null) {
                    setState(() {
                      takeAttendanceStatus = TakeAttendanceStatus.values
                          .firstWhere((element) => element.label == newValue);
                    });
                  }
                },
                items:
                    <String>[
                      TakeAttendanceStatus.notMarked.label,
                      TakeAttendanceStatus.onTime.label,
                      TakeAttendanceStatus.late.label,
                      TakeAttendanceStatus.absent.label,
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: value == TakeAttendanceStatus.notMarked.label
                                ? Colors.yellow.shade700
                                : value == TakeAttendanceStatus.onTime.label
                                ? Colors.green
                                : value == TakeAttendanceStatus.late.label
                                ? Colors.orange
                                : Colors.red,
                          ),
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
