import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/status_card.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/student_status_list_item.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class ClassOverviewScreen extends StatelessWidget {
  const ClassOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Class Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // 1. Status Cards Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1.65,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StatusCard(status: StudentStatus.onTrack, count: 24),
                StatusCard(status: StudentStatus.attention, count: 9),
                StatusCard(status: StudentStatus.behind, count: 7),
                StatusCard(status: StudentStatus.critical, count: 3),
              ],
            ),

            const SizedBox(height: 14),

            // 2. Student List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Student',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '38 Student',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                // Filter SVG Icon
                PopupMenuButton<String>(
                  color: Colors.white,
                  // The icon that triggers the menu
                  icon: SvgPicture.asset(Assets.icons.sort),
                  onSelected: (String result) {
                    // Handle the logic for each selection here
                    print('Selected: $result');
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'On Track',
                          child: Text('On Track'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Attention',
                          child: Text('Attention'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Behind',
                          child: Text('Behind'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Critical Risk',
                          child: Text('Critical Risk'),
                        ),
                      ],
                ),
              ],
            ),
            const Divider().paddingZero,

            // 3. Scrollable Student List
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return StudentStatusListItem(
                    name: "Azmir Khan",
                    phoneNumber: "01909352422",
                    imageUrl: Dummy.profileImageUrl,
                    onViewPressed: () {
                      Get.toNamed(AppRoutes.studentProgress);
                    },
                    status: StudentStatus.onTrack,
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
