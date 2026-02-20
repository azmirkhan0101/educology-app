import 'package:dr_dina_educology/modules/course_details/widgets/homework_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';

class HomeworkTab extends StatelessWidget {

  final bool showAddButton;

  const HomeworkTab({super.key, required this.showAddButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( showAddButton )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ButtonWidget(
            label: AppStrings.addHomework,
            prefixIcon: Icons.add,
            gradient: AppColors.primaryButtonGradient,
            buttonHeight: 45,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: "",
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM"
              ),
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: "",
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM"
              ),
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: "",
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM"
              ),HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: "",
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM"
              ),
            ],
          ),
        ),
      ],
    );
  }
}
