import 'package:dr_dina_educology/modules/course_details/widgets/announce_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';

class AnnounceTab extends StatelessWidget {

  final bool showAddButton;

  const AnnounceTab({super.key, required this.showAddButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( showAddButton )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ButtonWidget(
            label: AppStrings.announcement,
            prefixIcon: Icons.add,
            gradient: AppColors.primaryButtonGradient,
            buttonHeight: 45,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              AnnounceItemWidget(
                  userName: "Azmir Khan",
                  profileImageUrl: "",
                  dateTime: "20 Feb 2026 | 10:00 AM",
                  message: "Hello there, i am an announcement. Please read it carefully",
                  commentCount: 3
              ),
              AnnounceItemWidget(
                  userName: "Azmir Khan",
                  profileImageUrl: "",
                  dateTime: "20 Feb 2026 | 10:00 AM",
                  message: "Hello there, i am an announcement. Please read it carefully",
                  commentCount: 3
              ),
              AnnounceItemWidget(
                  userName: "Azmir Khan",
                  profileImageUrl: "",
                  dateTime: "20 Feb 2026 | 10:00 AM",
                  message: "Hello there, i am an announcement. Please read it carefully",
                  commentCount: 3
              ),
              AnnounceItemWidget(
                  userName: "Azmir Khan",
                  profileImageUrl: "",
                  dateTime: "20 Feb 2026 | 10:00 AM",
                  message: "Hello there, i am an announcement. Please read it carefully",
                  commentCount: 3
              ),
              AnnounceItemWidget(
                  userName: "Azmir Khan",
                  profileImageUrl: "",
                  dateTime: "20 Feb 2026 | 10:00 AM",
                  message: "Hello there, i am an announcement. Please read it carefully",
                  commentCount: 3
              )
            ],
          ),
        ),
      ],
    );
  }
}
