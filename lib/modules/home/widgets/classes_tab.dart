import 'package:dr_dina_educology/modules/home/widgets/class_item_widget.dart';
import 'package:flutter/material.dart';

class ClassesTab extends StatelessWidget {
  const ClassesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClassItemWidget(
            title: "Name",
            liveTime: "20 Dec 2026 | 10:00 AM",
            instructorName: "Azmir Khan",
            postDate: "20 Dec 2026 | 10:00 AM",
            instructorImageUrl: "",
            commentCount: 3
        ),
        ClassItemWidget(
            title: "Name",
            liveTime: "20 Dec 2026 | 10:00 AM",
            instructorName: "Azmir Khan",
            postDate: "20 Dec 2026 | 10:00 AM",
            instructorImageUrl: "",
            commentCount: 3
        ),
        ClassItemWidget(
            title: "Name",
            liveTime: "20 Dec 2026 | 10:00 AM",
            instructorName: "Azmir Khan",
            postDate: "20 Dec 2026 | 10:00 AM",
            instructorImageUrl: "",
            commentCount: 3
        ),
        ClassItemWidget(
            title: "Name",
            liveTime: "20 Dec 2026 | 10:00 AM",
            instructorName: "Azmir Khan",
            postDate: "20 Dec 2026 | 10:00 AM",
            instructorImageUrl: "",
            commentCount: 3
        )
      ],
    );
  }
}
