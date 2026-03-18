import 'package:dr_dina_educology/data/models/announcement/announce_model.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/announce_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../routes/app_pages.dart';

class AnnounceTab extends StatelessWidget {

  final ScrollController scrollController;
  final bool isMoreLoading;
  final bool showAddButton;
  final bool isLoading;
  final List<AnnounceModel> announcements;
  final VoidCallback onRefresh;
  final VoidCallback onAddAnnouncement;

  const AnnounceTab({
    super.key,
    required this.scrollController,
    required this.isMoreLoading,
    required this.showAddButton,
    required this.isLoading,
    required this.announcements,
    required this.onRefresh,
    required this.onAddAnnouncement
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        onRefresh();
      },
      backgroundColor: Colors.white,
      color: AppColors.primaryGold,
      child: Column(
        children: [
          if (showAddButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ButtonWidget(
                label: AppStrings.announcement,
                prefixIcon: Icons.add,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 45,
                onPressed: () {
                  onAddAnnouncement();
                },
              ),
            ),
          isLoading
              ? SizedBox(
                  height: 100,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGold,
                    ),
                  ),
                )
              : announcements.isEmpty
              ? SizedBox(
                  height: 180,
                  child: const Center(
                    child: Text(
                      "No announcements found.",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              : Expanded(child: mainBody(context)),
        ],
      ),
    );
  }

  //MAIN BODY
  Widget mainBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: announcements.length,
            itemBuilder: (context, index) {

              final AnnounceModel model = announcements[index];

              return AnnounceItemWidget(
                userName: model.teacher.fullName,
                profileImageUrl: model.teacher.image,
                createdAt: model.createdAt,
                htmlString: model.announce,
                commentCount: model.comments.length,
                onClick: () {
                  Get.toNamed(AppRoutes.announcementDetails, arguments: model);
                },
              );
            },
          ),
        ),
        if (isMoreLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CircularProgressIndicator(color: AppColors.primaryGold)),
          )
      ],
    );
  }
}
