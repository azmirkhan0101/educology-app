import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/notification/notification_model.dart';

class NotificationController extends GetxController{

  ApiService apiService = Get.find<ApiService>();
  RxBool isNotificationsLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  ScrollController notificationScrollController = ScrollController();
  RxBool isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;


  @override
  void onInit() {

    if( notifications.isEmpty ){
      getNotifications(isRefresh: true);
    }

    notificationScrollController.addListener((){
      if( notificationScrollController.position.pixels == notificationScrollController.position.maxScrollExtent ){
        if (isMoreLoading.value || !hasMoreData) return;
        if ( notificationScrollController.position.pixels >= notificationScrollController.position.maxScrollExtent * 0.9 ) {
          getNotifications(isRefresh: false);
        }
      }
    });

    super.onInit();
    }

  //GET NOTIFICATIONS
  Future<void> getNotifications({bool isRefresh = true}) async{

    if( isNotificationsLoading.value ){
      return;
    }

    if (isRefresh) {
      currentPage = 1;
      hasMoreData = true;
      isNotificationsLoading.value = true;
    } else {
      // If already loading or no more data to fetch, exit
      if (isMoreLoading.value || !hasMoreData) return;
      isMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getNotifications(page: currentPage)
    );
    isNotificationsLoading.value = false;
    isMoreLoading.value = false;
    if( response.statusCode == 200 ){
      final tempNotifications = (response.data['data']['notifications'] as List<dynamic>?) ?? [];
      List<NotificationModel> fetchedNotifications = tempNotifications.map<NotificationModel>((e){
        return NotificationModel.fromJson(e);
      }).toList();

      if( isRefresh ){
        notifications.value = fetchedNotifications;
      }else{
        notifications.addAll(fetchedNotifications);
      }
      if (fetchedNotifications.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }
    }
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