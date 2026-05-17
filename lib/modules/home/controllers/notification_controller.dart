import 'package:dr_dina_educology/core/helpers/pagination_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../data/models/notification/notification_model.dart';

class NotificationController extends GetxController{

  ApiService apiService = Get.find<ApiService>();
  ScrollController notificationScrollController = ScrollController();
  PaginationHelper notificationHelper = PaginationHelper<NotificationModel>();

  @override
  void onInit() {

    initNotificationHelper();

    if( notificationHelper.items.isEmpty ){
      getNotifications();
    }

    super.onInit();
    }

    //INIT NOTIFICATION HELPER
  void initNotificationHelper(){
    notificationHelper.init(
        endPoint: (page) => ApiEndpoints.getNotifications(page: page),
        fromJson: (json) => NotificationModel.fromJson(json),
        listExtractor: (data) => data['data']['notifications'] as List<dynamic>?,
      scrollController: notificationScrollController
    );
  }

  //GET NOTIFICATIONS
  Future<void> getNotifications() async{
    await notificationHelper.fetch(isRefresh: true, shouldPrint: true);
  }

  //NOTIFICATION MARK AS READ
  Future<void> notificationMarkAsRead({required String notificationId}) async{

    await apiService.networkRequest(
        method: "PATCH",
        isAuthRequired: true,
        endPoint: ApiEndpoints.notificationMarkAsRead(notificationId: notificationId),
        body: {}
    );
  }

  @override
  void onClose() {

    notificationScrollController.dispose();

    super.onClose();
  }
}