import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/text_widget.dart';
import '../widgets/participant_list_item.dart';

class ParticipantScreen extends StatelessWidget {
  const ParticipantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const TextWidget(
          text: "Participants",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
            Align(
            alignment: Alignment.topLeft,
            child: Text(
              textAlign: TextAlign.left,
              "Teacher",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ParticipantListItem(
            name: "Azmir Khan",
            phoneNumber: "01909352422",
            imageUrl: "",
            status: null,
            showDivider: false,
          ),
          SizedBox(height: 6),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              textAlign: TextAlign.left,
              AppStrings.assistants,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ParticipantListItem(
            name: "Azmir Khan",
            phoneNumber: "01909352422",
            imageUrl: "",
            status: null,
            showDivider: false,
          ),
          SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Student( 38 Students )',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider().paddingZero,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return ParticipantListItem(
                        name: "Azmir Khan",
                        phoneNumber: "01909352422",
                        imageUrl: "",
                        status: StudentStatus.critical,
                      );
                    },
                  ),
                ),
              ),
      ]
      )
      ),
    );
  }
}
