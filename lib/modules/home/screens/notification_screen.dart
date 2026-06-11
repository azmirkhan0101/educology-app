import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/data/models/notification/notification_model.dart';
import 'package:dr_dina_educology/modules/home/controllers/notification_controller.dart';
import 'package:dr_dina_educology/modules/home/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(
            text:AppStrings.notification,
          fontWeight: FontWeight.w600,
          fontSize: isTab ? 12.sp : 18,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryGold,
        onRefresh: (){
          return controller.getNotifications();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 15),
          child: Obx((){
            if( controller.notificationHelper.isLoading.value ) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryGold,),
              );
            }else if( controller.notificationHelper.items.isEmpty ){
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children:  [
                  SizedBox(height: 200), // Adjust to center the text
                  Center(child: Text("No notifications found", style: TextStyle(fontSize: isTab ? 10.sp : null),)),
                ],
              );
            }else{
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: controller.notificationScrollController,
                      itemCount: controller.notificationHelper.items.length,
                      itemBuilder: (context, index){

                        final NotificationModel notification = controller.notificationHelper.items[index];
                        RxBool read = notification.isRead.obs;

                        return Obx((){
                          return NotificationCard(
                              title: notification.title,
                              description: notification.message,
                              isRead: read.value,
                              time: notification.date,
                              onClick: (){
                                if( !notification.isRead ) {
                                  read.value = true;
                                  controller.notificationMarkAsRead(notificationId: notification.id);
                                }
                              }
                          );
                        });
                      }
                    ),
                  ),
                  Obx((){
                    if( controller.notificationHelper.isMoreLoading.value ){
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: CircularProgressIndicator(color: AppColors.primaryGold,),
                        ),
                      );
                    }else{
                      return const SizedBox();
                    }
                  })
                ],
              );
            }
          }
          ),
        ),
      )
    );
  }
}
